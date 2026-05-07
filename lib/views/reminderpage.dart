import 'package:dialo/constants/app_colors.dart';
import 'package:dialo/constants/app_textstyle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/leadProvider.dart';

class ReminderPage extends StatefulWidget {
  final String leadId; // ✅ IMPORTANT

  const ReminderPage({super.key, required this.leadId});

  @override
  State<ReminderPage> createState() => _ReminderPageState();
}

class _ReminderPageState extends State<ReminderPage> {

  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  TextEditingController noteController = TextEditingController();
  String? selectedCallStatus;

  List<String> callStatusList = [
    "Interested",
    "Not Interested",
    "Busy",
    "Call Later",
    "Out of Coverage Area",
  ];
  List<String> leadstage = [
    "Converted",
    "Follow Up",
    "Rejected",
  ];
  // 📅 Pick Date
  Future<void> pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  // ⏰ Pick Time
  Future<void> pickTime() async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  void saveReminder() {

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

    Provider.of<LeadProvider>(context, listen: false).updateReminder(
      leadId: widget.leadId,
      lastCallDate: lastCallDate,
      followUpDate: followUpDate,
      note: noteController.text,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Reminder Saved ✅")),
    );

    Navigator.pop(context);
    print("Lead ID: ${widget.leadId}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Set Reminder", style: AppTextstyle.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child:

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const Text(
                    "Called Date",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 8),

                  TextFormField(
                    readOnly: true,

                    controller: TextEditingController(
                      text: DateFormat('dd/MM/yyyy hh:mm a')
                          .format(DateTime.now()),
                    ),

                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.calendar_month),
                    ),
                  ),
              SizedBox(height: 20,),
                  const Text(
                    "Call Status",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 8),

                  DropdownButtonFormField<String>(
                    value: selectedCallStatus,

                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Select Call Status",
                    ),

                    items: callStatusList.map((status) {
                      return DropdownMenuItem<String>(
                        value: status,
                        child: Text(status),
                      );
                    }).toList(),

                    onChanged: (value) {
                      setState(() {
                        selectedCallStatus = value;
                      });
                    },
                  ),

                  SizedBox(height: 20,),
                  const Text(
                    "Lead Stage",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 8),

                  DropdownButtonFormField<String>(
                    value: leadstage,

                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Select Lead Stage",
                    ),

                    items: callStatusList.map((status) {
                      return DropdownMenuItem<String>(
                        value: status,
                        child: Text(status),
                      );
                    }).toList(),

                    onChanged: (value) {
                      setState(() {
                        selectedCallStatus = value;
                      });
                    },
                  ),
                  SizedBox(height: 20,),


              // 📦 DATE & TIME BOX
              Container(
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.textColor),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Text("Choose Custom Date & Time", style: AppTextstyle.dashBoardCard),
                    const SizedBox(height: 10),

                    // 📅 DATE
                    GestureDetector(
                      onTap: pickDate,
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.calendar_month, size: 20),
                            const SizedBox(width: 10),
                            Text(
                              selectedDate == null
                                  ? "Pick Date"
                                  : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    // ⏰ TIME
                    GestureDetector(
                      onTap: pickTime,
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.access_time, size: 20),
                            const SizedBox(width: 10),
                            Text(
                              selectedTime == null
                                  ? "Select Time"
                                  : selectedTime!.format(context),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 50),

              // 📝 NOTE BOX
              Container(
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.textColor),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Text("Reminder Note", style: AppTextstyle.dashBoardCard),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextField(
                        controller: noteController,
                        decoration: const InputDecoration(
                          labelText: "What should you remember to do ?",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 50),

              // 🔘 BUTTON
              InkWell(
                onTap: saveReminder,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  width: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.themeColor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.notifications_active_outlined, color: Colors.white),
                      SizedBox(width: 10),
                      Text(
                        "Schedule Reminder",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}