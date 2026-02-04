import 'package:dialo/constants/app_colors.dart';
import 'package:dialo/constants/app_textstyle.dart';
import 'package:dialo/views/reminderpage.dart';
import 'package:flutter/material.dart';

class LeadDetails extends StatefulWidget {
  const LeadDetails({super.key});

  @override
  State<LeadDetails> createState() => _LeadDetailsState();
}

class _LeadDetailsState extends State<LeadDetails> {
  TextEditingController dateController = TextEditingController();
  String? selectedStatus;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whitetext,
      appBar: AppBar(
        backgroundColor: AppColors.whitetext,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
        ),
        title: const Text(
          "Riswana",
          style: AppTextstyle.title,
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(left: 100),
            height: 30,
            decoration: BoxDecoration(
              color: AppColors.themeColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ReminderPage(),
                      ),
                    );
                  },
                  child: Row(
                    children: const [
                      Icon(Icons.notifications_active_outlined, color: AppColors.whitetext,),
                      Text("Set Reminder",style: TextStyle( color: AppColors.whitetext,),),
                      SizedBox(width: 4),

                    ],
                  ),
                ),
               ]
          ),
          ),
    IconButton(icon:Icon(Icons.edit_note),onPressed:(){
    Navigator.push(context,MaterialPageRoute(builder: (_)=>ReminderPage(),));
    }
    ),
    ],
    ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 170,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.greenColor,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.call_outlined,
                              color: AppColors.whitetext,
                            ),
                            Text(
                              "Call Now",
                              style: TextStyle(color: AppColors.whitetext),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 170,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.greenColor,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.chat_outlined,
                              color: AppColors.whitetext,
                            ),
                            Text(
                              "WhatsApp",
                              style: TextStyle(color: AppColors.whitetext),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Text("Status", style: AppTextstyle.SubTitle)],
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                height: 30,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.textColor),
                ),
                child: Row(children: [
                  Text("Add status"),
                  const SizedBox(width: 10,),
                  Expanded(child:
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                    ),
                    hint: const Text("Select"),
                    items: const [
                      DropdownMenuItem(
                        value: "Interested",
                        child: Text("Interested"),
                      ),
                      DropdownMenuItem(
                        value: "Contacted",
                        child: Text("Contacted"),
                      ),
                      DropdownMenuItem(
                        value: "Not Interested",
                        child: Text("Not Interested"),
                      ),
                      DropdownMenuItem(
                        value: "Call Connected",
                        child: Text("Call Connected"),
                      ),
                      DropdownMenuItem(
                        value: "Call Not Connected",
                        child: Text("Call Not Connected"),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        selectedStatus = value;
                      });

                    },
                  ),
                  )
                ]
                    
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [Text("Interaction", style: AppTextstyle.SubTitle)],
              ),
              const SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  hintText: "Add note / type here",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.textColor),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.textColor),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Contact information", style: AppTextstyle.SubTitle),
                ],
              ),
              const SizedBox(height: 5),
              TextField(
                decoration: InputDecoration(
                  hintText: "enter place",
                  labelText: 'Place',
                  prefixIcon: Icon(
                    Icons.location_on_outlined,
                    color: AppColors.textColor,
                  ),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 5),
              TextField(
                decoration: InputDecoration(
                  hintText: "enter phone number",
                  labelText: 'phone',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.phone, color: AppColors.textColor),
                ),
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Education details", style: AppTextstyle.SubTitle),
                ],
              ),
              const SizedBox(height: 5),
              TextField(
                decoration: InputDecoration(
                  hintText: "Education",
                  labelText: 'Education',
                  prefixIcon: Icon(
                    Icons.cast_for_education,
                    color: AppColors.textColor,
                  ),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 5),
              TextField(
                decoration: InputDecoration(
                  hintText: "Interested course",
                  labelText: 'Course',
                  prefixIcon: Icon(
                    Icons.menu_book_outlined,
                    color: AppColors.textColor,
                  ),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 5),
              TextField(
                controller: TextEditingController(),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Created date",
                  labelText: "Choose date",
                  prefixIcon: IconButton(
                    icon: const Icon(Icons.calendar_today, color: Colors.black),
                    onPressed: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      );
                      if (pickedDate != null) {
                        "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  Text("Interaction history", style: AppTextstyle.SubTitle),
                  Spacer(),
                  InkWell(
                    onTap: () {},
                    child: Row(
                      children: const [
                        Text("View All"),
                        SizedBox(width: 4),
                        Icon(Icons.arrow_forward, size: 18),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                height: 100,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.textColor),
                  borderRadius: BorderRadius.circular(5),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
