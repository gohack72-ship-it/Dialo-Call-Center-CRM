import 'package:dialo/constants/app_colors.dart';
import 'package:dialo/constants/app_textstyle.dart';
import 'package:dialo/views/leaddetails.dart';
import 'package:flutter/material.dart';

class ReminderPage extends StatefulWidget {
  const ReminderPage({super.key});

  @override
  State<ReminderPage> createState() => _ReminderPageState();
}

class _ReminderPageState extends State<ReminderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(
  centerTitle: true,
  title: Text("Set Reminder",style:AppTextstyle.title,),
  
),
      body: Padding(
        padding: const EdgeInsets.all(7),
        child: Column(
          children: [
            Center(
              child: Container(
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                decoration: BoxDecoration(
                  border:Border.all(color: AppColors.textColor),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Text("Choose Custom Date & Time",style: AppTextstyle.SubTitle,),
          const SizedBox(height: 10),
          TextField(
            decoration: InputDecoration(
              hintText: "Pick a Date",
              labelText: 'Date',
              prefixIcon: Icon(
                Icons.calendar_month,
                color: AppColors.textColor,
              ),
              border: OutlineInputBorder(),
            ),
          ),const SizedBox(height: 5),
                    TextField(
                      decoration: InputDecoration(
                        hintText: "Select Time",
                        labelText: 'Time',
                        prefixIcon: Icon(
                          Icons.access_time,
                          color: AppColors.textColor,
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),

              ),
            ),
            const SizedBox(height: 50),
            Center(
              child: Container(
                padding: EdgeInsets.all(10),
                width: double.infinity,
                decoration: BoxDecoration(
                  border:Border.all(color: AppColors.textColor),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Text("Reminder Note*",style: AppTextstyle.SubTitle,),
                   TextField(
                     decoration: InputDecoration(
                       labelText: "What should you remember to do ?",
                       border: OutlineInputBorder(),
                     ),


                   ),
                  ],
                ),

              ),
            ),
            const SizedBox(height: 50),
            InkWell(
              onDoubleTap:() {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const LeadDetails(),
                  ),
                );

              },
              child: Container(
                padding: EdgeInsets.all(5),
                width: 170,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.themeColor,
                ),

                child: Row(
                  children: [
                    Icon(Icons.notifications_active_outlined,color: AppColors.whitetext,),
                    Text("Schedule Reminder",style:TextStyle(color: AppColors.whitetext),),

                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
