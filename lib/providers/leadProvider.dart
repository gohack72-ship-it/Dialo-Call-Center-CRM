import 'dart:core';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dialo/models/lead_details_Model.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:provider/provider.dart';

class LeadProvider extends ChangeNotifier {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController placeController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  final TextEditingController sourceController = TextEditingController();
  final TextEditingController followUpNoteController = TextEditingController();
  final TextEditingController calledDateController = TextEditingController(text: DateFormat('dd/MM/yyyy hh:mm a')
        .format(DateTime.now()),);

  int dueToday = 0;
  int thisWeek = 0;

  bool isLoading = false;

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  void clearLeadControllers(){
    nameController.clear();
    placeController.clear();
    phoneController.clear();
    emailController.clear();
    sourceController.clear();
    selectedStatus = null;

    selectedLeadsFilters.clear();
    notifyListeners();
  }


   TextEditingController searchController = TextEditingController();
   String searchText = "";String? selectedLeadStage;

  Map<String, int> leadStatusCountMap = {};
  List<String> statusList = [];
  List<String> callStatusList = [];

  List<LeadDetailsModel> additionalLeadDetailsList = [];
  List<Map<String, dynamic>> _todaysLeadsList = [];
  List<Map<String, dynamic>> get todaysLeadsList => _todaysLeadsList;
  Map<String, dynamic> selectedLeadsFilters = {};

  String? selectedStatus;

  FirebaseFirestore fdb = FirebaseFirestore.instance;
  int totalLeads = 0;
  int followUps = 0;
  int todayCalls = 0;
  int overdue = 0;

  LeadProvider() {
    getLeadStatus();
    Future.delayed(Duration(seconds: 2), () {
      getStatusCounts();
    });
  }

  Future<void> getStatusCounts() async {
    log("Fetching lead status counts... ${statusList.length} statuses found");
    leadStatusCountMap = {};
    try{
    for (var status in statusList) {
      final snap = await fdb
          .collection("LEADS")
          .where("LEAD_STATUS", isEqualTo: status)
          .count()
          .get();

      int count = snap.count ?? 0;
      leadStatusCountMap[status] = count;
    }
    } catch (e) {
      log("Error fetching lead status counts: $e");
    }
log("Lead Status: ${leadStatusCountMap.length}");
    notifyListeners();
  }

  List<Map<String, dynamic>> leadList = [];
  Future<void> getLeads() async {
    final snapshot = await FirebaseFirestore.instance.collection("LEADS").get();

    leadList = snapshot.docs.map((doc) {
      return {
        "name": doc["NAME"],
        "phone": doc["PHONE"],
        "status": doc["LEAD_STATUS"],
        "staff": doc["ASSIGNED_AGENT_ID"],

        "statusColor": Colors.green.shade100,
        "statusText": Colors.green,
      };
    }).toList();

    notifyListeners();
  }

  Map<String, int> statusCounts = {};

  fetchCallStatusCounts() async {
    final snapshot = await FirebaseFirestore.instance.collection("LEADS").get();

    print("callStatusList: $callStatusList");

    for (var status in callStatusList) {
      final count = snapshot.docs
          .where((doc) => doc['CALL_STATUS'] == status)
          .length;

      statusCounts[status] = count;
    }
    print(statusCounts);
    notifyListeners();
  }





  Future<void> addNewLead() async {
    DateTime now = DateTime.now();
    String id = now.millisecondsSinceEpoch.toString();

    String tempAgentId = "";


    try {
      final agentSnapshot = await fdb.collection("AGENT").get();

      final leadsSnapshot = await fdb.collection("LEADS").get();
      int leadCount = leadsSnapshot.docs.length;

      if (agentSnapshot.docs.isNotEmpty) {
        int index = (leadCount ~/ 2) % agentSnapshot.docs.length;

        tempAgentId = agentSnapshot.docs[index].id;
      }
    } catch (e) {
      print("Agent fetch error: $e");
    }

    final lead = {
      "NAME": nameController.text,
      "PLACE": placeController.text,
      "PHONE": phoneController.text,
      "EMAIL": emailController.text,
      "LEAD_ID": id,

      "ADDED_BY_ID": tempAgentId,
      "ASSIGNED_AGENT_ID": tempAgentId,
      "ASSIGNED_AGENT_NAME": "NAME",
      "ADDED_TIME": Timestamp.fromDate(now),
      "LEAD_STATUS": selectedStatus ?? "New",
      "LEAD_CATEGORY": "",
      "CALL_STATUS": "",
      "SOURCE": sourceController.text,

      "FOLLOW_UP_DATE": Timestamp.fromDate(now.add(const Duration(days: 3))),
      "FOLLOW_UP_TIME": "",
      "LAST_CONTACTED_DATE": Timestamp.fromDate(now),
      "PRIORITY": 'Medium',

      "FOLLOW_UP_STATUS": "FOLLOW_UP",
      "ADDITIONAL_LEAD_DETAILS": selectedLeadsFilters,
    };

    await fdb.collection("LEADS").doc(id).set(lead);


    clearData();
    notifyListeners();
  }

  void addFollowUp (String leadId){
    print("Lead ID: $leadId");
    DateTime now = DateTime.now();
    String id = now.millisecondsSinceEpoch.toString();
    DateTime calledDate =
    DateFormat('d/MM/yyyy HH:mm')
        .parse(calledDateController.text);
    Map<String, dynamic> followUp = {
    "CALL_STATUS": selectedCallStatus,
      "CALL_DATE":calledDate ,
      "LEAD_STATUS": selectedLeadStage,
      "TIME": "${selectedTime?.hour}:${selectedTime?.minute}",
      "DATE": selectedDate,
      "NOTE": followUpNoteController.text,

    };
     fdb.collection("LEADS").doc(leadId).collection("FOLLOW_UPS").doc(id).set(followUp) ;

  }

  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  String? selectedCallStatus;
  String? selectedLeadStatus;

  get leadStatusList => null;


  // 📅 Pick Date
  Future<void> pickDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      selectedDate = picked;
    }
    notifyListeners();
  }
  void clearReminderForm() {

    followUpNoteController.clear();

    selectedCallStatus = null;
    selectedLeadStage = null;
    selectedDate = null;
    selectedTime = null;

    notifyListeners();
  }

  // ⏰ Pick Time
  Future<void> pickTime(BuildContext context) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      selectedTime = picked;
    }
    notifyListeners();
  }

  void saveReminder(String leadId, BuildContext context) {
    if (selectedDate == null || selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select date & time")),
      );
      return;
    }

    // ✅ TODAY (current time)
    DateTime lastCallDate = DateTime.now();

    // ✅ USER SELECTED (follow-up)
    DateTime followUpDate = DateTime(
      selectedDate!.year,
      selectedDate!.month,
      selectedDate!.day,
      selectedTime!.hour,
      selectedTime!.minute,
    );

    // 🔍 DEBUG PRINT
    print("Last Call (NOW): $lastCallDate");
    print("Follow Up (SELECTED): $followUpDate");

    updateReminder(
      leadId: leadId,
      lastCallDate: lastCallDate,
      followUpDate: followUpDate,
      note: noteController.text,
    );

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Reminder Saved ✅")));

    Navigator.pop(context);
    print("Lead ID: ${leadId}");
  }

  Future<void> fetchTodaysWorkload() async {
    DateTime now = DateTime.now();
    DateTime startOfDay = DateTime(now.year, now.month, now.day);
    DateTime endOfDay = startOfDay.add(const Duration(days: 1));

    try {
      // Filter LEADS where FOLLOW_UP_DATE is between today 00:00 and 23:59
      final snapshot = await fdb
          .collection("LEADS")
          .where("FOLLOW_UP_DATE", isGreaterThanOrEqualTo: startOfDay)
          .where("FOLLOW_UP_DATE", isLessThan: endOfDay)
          .get();

      _todaysLeadsList = snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();

      // Update the counts for the dashboard while we are at it
      dueToday = _todaysLeadsList.length;

      notifyListeners();
    } catch (e) {
      print("Workload Fetch Error: $e");
    }
  }

  void clearData() {
    nameController.clear();
    placeController.clear();
    emailController.clear();
    phoneController.clear();
    emailController.clear();

    sourceController.clear();
    selectedStatus = null;

    //  DON'T CLEAR statusList

    notifyListeners();
  }

  Future<void> getCallStatusList() async {
    fdb.collection("LEAD_SETTINGS").doc("call_status").get().then((value) {
      callStatusList.clear();
      if (value.exists) {
        Map<String, dynamic> statusMap = value.data() as Map<String, dynamic>;
        List<dynamic> dynamicList = statusMap["callStatusList"];
        callStatusList = dynamicList.map((e) => e.toString()).toList();
      }
      print("Status List: $callStatusList");
      notifyListeners();
    });
  }

 Future<void> getLeadStatus() async {
    await fdb.collection("LEAD_SETTINGS").doc("lead_status").get().then((
      value,
    ) {
      statusList.clear();
      if (value.exists) {
        Map<String, dynamic> statusMap = value.data() as Map<String, dynamic>;
        List<dynamic> dynamicList = statusMap["leadStatusList"];
        statusList = dynamicList.map((e) => e.toString()).toList();
      }
      print("Status List: $statusList");
      notifyListeners();
    });
  }

  Future<void> calculateWorkload() async {
    DateTime now = DateTime.now();

    DateTime startOfDay = DateTime(now.year, now.month, now.day);
    DateTime endOfDay = startOfDay.add(Duration(days: 1));

    DateTime startOfWeek = startOfDay.subtract(Duration(days: now.weekday - 1));
    DateTime endOfWeek = startOfWeek.add(Duration(days: 7));

    try {
      final snapshot = await fdb.collection("LEADS").get();

      int todayCount = 0;
      int weekCount = 0;

      for (var doc in snapshot.docs) {
        final data = doc.data();

        if (data["FOLLOW_UP_DATE"] != null &&
            data["FOLLOW_UP_STATUS"] == "pending") {
          DateTime followUpDate = (data["FOLLOW_UP_DATE"] as Timestamp)
              .toDate();

          // Due today
          if (followUpDate.isAfter(startOfDay) &&
              followUpDate.isBefore(endOfDay)) {
            todayCount++;
          }

          // This week
          if (followUpDate.isAfter(startOfWeek) &&
              followUpDate.isBefore(endOfWeek)) {
            weekCount++;
          }
        }
      }

      dueToday = todayCount;
      thisWeek = weekCount;

      notifyListeners();
    } catch (e) {
      print("Workload error: $e");
    }
  }

  void changeStatus(String status) {
    selectedStatus = status;
    notifyListeners();
  }

  Future<void> updateReminder({
    required String leadId,
    required DateTime lastCallDate,
    required DateTime followUpDate,
    required String note,
  }) async {
    try {
      await fdb.collection("LEADS").doc(leadId).update({
        "LAST_CONTACTED_DATE": Timestamp.fromDate(lastCallDate),
        "FOLLOW_UP_DATE": Timestamp.fromDate(followUpDate),
        "FOLLOW_UP_STATUS": "FOLLOW_UP",
        "NOTE": note,
      });

      print("✅ Reminder Updated for Lead: $leadId");
      print("Last Call: $lastCallDate");
      print("Follow Up: $followUpDate");
      print("Note: $note");
    } catch (e) {
      print("❌ Error updating reminder: $e");
    }
  }

  Future<void> fetchAdditionalLeadDetails() async {
    await fdb.collection("LEAD_SETTINGS").doc("categories").get().then((value) {
      if (value.exists) {
        additionalLeadDetailsList.clear();
        Map<String, dynamic> data = value.data() as Map<String, dynamic>;
        List<dynamic> categoryList = data["categoryList"];

        for (var element in categoryList) {
          additionalLeadDetailsList.add(
            LeadDetailsModel(
              sub: (element['sub'] as List<dynamic>)
                  .map((e) => e.toString())
                  .toList(),
              title: element["title"],
            ),
          );
        }
        print(additionalLeadDetailsList.length);
        notifyListeners();
      }
    });
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri url = Uri(scheme: 'tel', path: phoneNumber);

    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> updateLead(String id) async {
    await FirebaseFirestore.instance
        .collection("LEADS")
        .doc(id)
        .update({

      "NAME": nameController.text,
      "PLACE": placeController.text,
      "PHONE": phoneController.text,
      "EMAIL": emailController.text,
      "SOURCE": sourceController.text,
      "LEAD_STATUS": selectedStatus,

      "ADDITIONAL_LEAD_DETAILS": selectedLeadsFilters,

      "UPDATED_AT": FieldValue.serverTimestamp(),
    });
    clearLeadControllers();
  }

  Future<void> loadDashboardCounts() async {
    try {
      final db = FirebaseFirestore.instance;

      DateTime now = DateTime.now();

      DateTime start = DateTime(now.year, now.month, now.day);

      DateTime end = start.add(const Duration(days: 1));

      final totalSnap = await db.collection("LEADS").count().get();

      final followSnap = await db
          .collection("LEADS")
          .where("FOLLOW_UP_STATUS", isEqualTo: "FOLLOW_UP")
          .where(
            "FOLLOW_UP_DATE",
            isGreaterThanOrEqualTo: Timestamp.fromDate(start),
          )
          .where("FOLLOW_UP_DATE", isLessThan: Timestamp.fromDate(end))
          .count()
          .get();

      print("follow snap finished ${followSnap.count!}");

      final todaySnap = await db
          .collection("LEADS")
          .where(
            "LAST_CONTACTED_DATE",
            isGreaterThanOrEqualTo: Timestamp.fromDate(start),
          )
          .where("LAST_CONTACTED_DATE", isLessThan: Timestamp.fromDate(end))
          .count()
          .get();
      print("today snap finished");

      final overdueSnap = await db
          .collection("LEADS")
          .where("FOLLOW_UP_DATE", isLessThan: Timestamp.fromDate(start))
          .where("FOLLOW_UP_STATUS", isEqualTo: "FOLLOW_UP")
          .count()
          .get();
      print("overdue finished");

      totalLeads = totalSnap.count ?? 0;
      followUps = followSnap.count ?? 0;
      todayCalls = todaySnap.count ?? 0;
      overdue = overdueSnap.count ?? 0;

      notifyListeners();
    } catch (e) {
      print("Dashboard Count Error: $e");
    }
  }

  void changeLeadStage(String s) {}
}
