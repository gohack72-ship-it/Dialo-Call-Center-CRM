import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dialo/models/lead_details_Model.dart';


import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:provider/provider.dart';

class LeadProvider extends ChangeNotifier {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController placeController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  final TextEditingController sourceController = TextEditingController();
  int dueToday = 0;
  int thisWeek = 0;

   TextEditingController searchController = TextEditingController();
   String searchText = "";

  List<String> statusList = [];
  List<LeadDetailsModel> additionalLeadDetailsList = [];
  Map<String, dynamic> selectedLeadsFilters = {};

  String? selectedStatus;


  FirebaseFirestore fdb = FirebaseFirestore.instance;

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

      "ADDED_TIME": now,
      "STATUS": selectedStatus ?? "NEW",
      "SOURCE": sourceController.text,

      "FOLLOW_UP_DATE": now.add(const Duration(days: 3)),
      "FOLLOW_UP_TIME": "",
      "LAST_CONTACTED_DATE": now,
      "PRIORITY": 'Medium',

      "FOLLOW_UP_STATUS": "pending",
      "ADDITIONAL_LEAD_DETAILS": selectedLeadsFilters,
    };

    await fdb.collection("LEADS").doc(id).set(lead);

    clearData();
  }

  void clearData() {
    nameController.clear();
    placeController.clear();
    phoneController.clear();
    emailController.clear();


    //  DON'T CLEAR statusList

    notifyListeners();
  }

  void getLeadStatus() async {
    fdb.collection("LEAD_STATUS").get().then((value) {
      statusList.clear();
      if (value.docs.isNotEmpty) {
        for (var element in value.docs) {
          Map<String, dynamic> statusMap = element.data();
          statusList.add(statusMap["STATUS"]);
        }
      }

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

          DateTime followUpDate =
          (data["FOLLOW_UP_DATE"] as Timestamp).toDate();

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
        "LAST_CONTACTED_DATE": lastCallDate,
        "FOLLOW_UP_DATE": followUpDate,
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
}