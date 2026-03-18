
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dialo/models/statusModel.dart';
import 'package:flutter/cupertino.dart';


class LeadProvider extends ChangeNotifier {

  final TextEditingController nameController = TextEditingController();
  final TextEditingController placeController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController educationController = TextEditingController();
  final TextEditingController interestedController = TextEditingController();
  List<StatusModel> statusList = [];

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

    };

  fdb.collection("LEADS").doc(id).set(lead,);



  }

  void getLeadStatus()async{
    fdb.collection("LEAD_STATUS").get().then((value){
      if (value.docs.isNotEmpty){
        for (var element in value.docs){
          Map<String,dynamic>statusMap = element.data();
statusList.add(StatusModel(status: statusMap["STATUS"]));



        }

      }

notifyListeners();

    });
  }

}

