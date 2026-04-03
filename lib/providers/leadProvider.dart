import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dialo/models/lead_details_Model.dart';


import 'package:flutter/cupertino.dart';

class LeadProvider extends ChangeNotifier {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController placeController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController sourceController = TextEditingController();


  List<String> statusList = [];
  List<LeadDetailsModel> additionalLeadDetailsList = [];
  List<Map<String, dynamic>> selectedLeadsFilters = [];

  String? selectedStatus;

  FirebaseFirestore fdb = FirebaseFirestore.instance;

  void addNewLead() {
    DateTime now = DateTime.now();
    String id = now.millisecondsSinceEpoch.toString();
    final lead = {
      "NAME": nameController.text,
      "PLACE": placeController.text,
      "PHONE": phoneController.text,
      "EMAIL": emailController.text,
      "LEAD_ID": id,
      "ADDED_BY_ID": "",
      "ADDED_TIME":now,
      "STATUS": selectedStatus ?? "NEW",
      "SOURCE":sourceController.text,

      "FOLLOW_UP_DATE":now.add(Duration(days: 3)),
      "FOLLOW_UP_TIME":"",
      "PRIORITY":'Medium',
      "ASSIGNED_AGENT":"",
      "FOLLOW_UP_STATUS":"pending",
    };

    fdb.collection("LEADS").doc(id).set(lead);

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