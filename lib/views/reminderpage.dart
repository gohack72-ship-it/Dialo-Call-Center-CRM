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



  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<LeadProvider>().getCallStatusList();
      context.read<LeadProvider>().getLeadStatus();



    });
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

                    controller: context.watch<LeadProvider>().calledDateController,

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

                  Consumer<LeadProvider>(
                    builder: (context,val, child) {
                      return DropdownButtonFormField<String>(
                        value: val.selectedCallStatus,

                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Select Call Status",
                        ),

                        items: val.callStatusList.map((status) {
                          return DropdownMenuItem<String>(
                            value: status,
                            child: Text(status),
                          );
                        }).toList(),

                        onChanged: (value) {
                          val.selectedCallStatus = value;
                          val.notifyListeners();
                        },
                      );
                    }
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

                  Consumer<LeadProvider>(
                    builder: (context, valu, child) {
                      return DropdownButtonFormField<String>(
                        value: valu.statusList.contains(valu.selectedLeadStage)
                            ? valu.selectedLeadStage
                            : null,

                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Select Lead Stage",
                        ),

                        items: valu.statusList.map((status) {
                          return DropdownMenuItem<String>(
                            value: status,
                            child: Text(status),
                          );
                        }).toList(),

                        onChanged: (val) {
                          valu.changeLeadStage(val!);
                        },
                      );
                    },
                  ),
                  SizedBox(height: 20,),


              // 📦 DATE & TIME BOX
              Consumer<LeadProvider>(
                builder: (context,valu,child) {
                  if ((valu.selectedLeadStage ?? "").toLowerCase() != "follow_up") {
                    print((valu.selectedLeadStage ?? "").toLowerCase());
                    print("tttttttttttttt");
                    return const SizedBox();

                  }
                  return Container(
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
                          onTap: (){
                            context.read<LeadProvider>().pickDate(context);

                          },
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
                               Consumer<LeadProvider>(
                                  builder: (context,val,child) {
                                    return Text(
                                     val.selectedDate == null
                                          ? "Pick Date"
                                          : "${val.selectedDate!.day}/${val.selectedDate!.month}/${val.selectedDate!.year}",
                                    );
                                  }
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),

                        // ⏰ TIME
                        GestureDetector(
                          onTap: (){
                            context.read<LeadProvider>().pickTime(context);
                          },
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
                                Consumer<LeadProvider>(
                                  builder: (context,val,child) {
                                    return Text(
                                      val.selectedTime == null
                                          ? "Select Time"
                                          : val.selectedTime!.format(context),
                                    );
                                  }
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
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
                      child: Consumer<LeadProvider>(
                        builder: (context,val,child) {
                          return TextField(
                            controller: val.followUpNoteController,
                            decoration: const InputDecoration(
                              labelText: "What should you remember to do ?",
                              border: OutlineInputBorder(),
                            ),
                          );
                        }
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 50),

              // 🔘 BUTTON
              InkWell(
                onTap: (){
                  context.read<LeadProvider>().saveReminder(widget.leadId, context);
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  width: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.themeColor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:  [
                      Icon(Icons.notifications_active_outlined, color: Colors.white),
                      SizedBox(width: 10),
                      TextButton(
                        onPressed: (){
                        context.read<LeadProvider>().addFollowUp(widget.leadId);
                        context.read<LeadProvider>().clearReminderForm();
                        Navigator.pop(context);

                        },
                        child: Text("Save Reminder", style: TextStyle(color: Colors.white)),
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