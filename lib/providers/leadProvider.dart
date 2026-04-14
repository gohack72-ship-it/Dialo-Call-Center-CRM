import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dialo/models/lead_details_Model.dart';


import 'package:flutter/cupertino.dart';
// import 'package:provider/provider.dart';

class LeadProvider extends ChangeNotifier {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController placeController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController sourceController = TextEditingController();


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

  void changeStatus(String status) {
    selectedStatus = status;
    notifyListeners();
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
}