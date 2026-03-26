
import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/cupertino.dart';


class LeadProvider extends ChangeNotifier {

  final TextEditingController nameController = TextEditingController();
  final TextEditingController placeController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController educationController = TextEditingController();
  final TextEditingController interestedController = TextEditingController();
  List<String> statusList = [];

  String? selectedStatus;

  FirebaseFirestore fdb = FirebaseFirestore.instance;

  void addNewLead() {
    DateTime now = DateTime.now();
    String id = now.millisecondsSinceEpoch.toString();
  final  lead = {
    "NAME": nameController.text,
    "PLACE": placeController.text,
    "PHONE": phoneController.text,
     "LEAD_ID":id,
    "ADDED_BY_ID":"",
    "ADDED_TIME":now,
    "STATUS":"NEW",

    };

  fdb.collection("LEADS").doc(id).set(lead,);

clearData();

  }
void clearData(){
    nameController.clear();
    placeController.clear();
    phoneController.clear();
    statusList.clear();

    notifyListeners();
}

  void getLeadStatus()async{
    fdb.collection("LEAD_STATUS").get().then((value){
      if (value.docs.isNotEmpty){
        for (var element in value.docs){
          Map<String,dynamic>statusMap = element.data();
statusList.add( statusMap["STATUS"]);



        }

      }

notifyListeners();

    });
  }

  void changeStatus(String status){
    selectedStatus = status;
  }

}

void getDetails() async{
  await fdb.collection("LEADS").then((value){


}
