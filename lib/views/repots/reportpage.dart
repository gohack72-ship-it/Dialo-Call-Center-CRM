import 'package:dialo/constants/app_colors.dart';
import 'package:dialo/constants/app_textstyle.dart';
import 'package:dialo/models/leadModel.dart';
import 'package:dialo/providers/leadProvider.dart';

import 'package:dialo/views/repots/reportsum.dart';
import 'package:dialo/views/settingspage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';


class Reportpage extends StatefulWidget {
  final Function(bool) changeTheme;

  const Reportpage({super.key, required this.changeTheme});


  

  @override
  State<Reportpage> createState() => _ReportpageState();
}

class _ReportpageState extends State<Reportpage> {

  final int _currentIndex = 0;
  String selectedReportType = "Today's data";
  List<LeadModel> allLeads = [];

Map<String, int> analyticsData = {};

bool isLoading = false;

int total = 0;

@override
void initState() {
  super.initState();
 

  
}
 
  Widget analyticsItem({
    required String title,
    required String count,
    required Color color,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),

              Text(
                count,
                style: TextStyle(
                  color: color,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: LinearProgressIndicator(
              value: 0,
              minHeight: 10,
              backgroundColor: color.withOpacity(0.15),
              valueColor: AlwaysStoppedAnimation(color),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

    

      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
       drawer: SettingsDrawer(changeTheme:widget.changeTheme),



      appBar: AppBar(
        title: const Text(
          "Reports",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),

        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    SettingsDrawer(changeTheme: widget.changeTheme),
              ),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                cursorColor: AppColors.whitetext,
                decoration: InputDecoration(
                  hintText: "Search Leads",
                  prefixIcon: const Icon(Icons.search),
                  filled: true,

                

                  fillColor:Theme.of(context).brightness == Brightness.dark
                          ? Colors.grey.shade800
                          : Colors.white,

                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              // const SizedBox(height: 30),
              // Text("Summary card", style: AppTextstyle.SubTitle),
              // const SizedBox(height: 30),
              // SingleChildScrollView(
              //   scrollDirection: Axis.horizontal,
              //   child: Row(
              //     children: [
                   
              //         Column(
              //           children: [

                          
              //             const SizedBox(height: 10),
                         
              //             // ... inside your Row's children, replace the first Container with this:

              //             Container(
              //               width: 200,
              //               padding: const EdgeInsets.all(15),
              //               decoration: BoxDecoration(
              //                 color: AppColors.whitetext,
              //                 border: Border.all(color: AppColors.textColor),
              //                 borderRadius: BorderRadius.circular(10),
              //               ),
              //               child: Column(
              //                 children: [
              //                   Text(
              //                     "Today's workload",
              //                     style: AppTextstyle.MiniText.copyWith(
              //                 color: Theme.of(context).textTheme.bodyLarge?.color
              //               )
              //                   ),
              //                   const SizedBox(height: 10),

              //                   // Dynamic Data Section
              //                   Consumer<LeadProvider>(
              //                     builder: (context, provider, child) {
              //                       return Column(
              //                         children: [
              //                           Text(
              //                             "${provider.dueToday}",
              //                             style: const TextStyle(
              //                                 fontSize: 24,
              //                                 fontWeight: FontWeight.bold,
              //                                 color: AppColors.themeColor
              //                             ),
              //                           ),
              //                           const Text("Leads Due Today", style: TextStyle(fontSize: 10)),
              //                         ],
              //                       );
              //                     },
              //                   ),

              //                   const SizedBox(height: 15),

              //                   // Comparison Row
              //                   Row(
              //                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //                     children: [
              //                       const Text("This week", style: TextStyle(fontSize: 12)),
              //                       Consumer<LeadProvider>(
              //                         builder: (context, provider, child) {
              //                           return Text(
              //                             "${provider.thisWeek}",
              //                             style: const TextStyle(fontWeight: FontWeight.bold),
              //                           );
              //                         },
              //                       ),
              //                       const CircleAvatar(
              //                         radius: 5,
              //                         backgroundColor: AppColors.themeColor,
              //                       ),
              //                     ],
              //                   ),

              //                   const SizedBox(height: 10),

              //                   // View Button
              //                   Container(
              //                     decoration: BoxDecoration(
              //                       border: Border.all(color: Colors.black12),
              //                       borderRadius: BorderRadius.circular(5),
              //                     ),
              //                     child: InkWell(
              //                       onTap: () {
              //                         Navigator.push(
              //                           context,
              //                           MaterialPageRoute(
              //                             builder: (_) => const ReportSum(),
              //                           ),
              //                         );
              //                       },
              //                       child: Row(
              //                         mainAxisAlignment: MainAxisAlignment.center,
              //                         children: const [
              //                           Padding(
              //                             padding: EdgeInsets.symmetric(vertical: 4),
              //                             child: Text(
              //                               "View detailed report",
              //                               style: TextStyle(fontSize: 10),
              //                             ),
              //                           ),
              //                           Icon(Icons.arrow_forward, size: 14),
              //                         ],
              //                       ),
              //                     ),
              //                   ),
              //                 ],
              //               ),

              //             ),
              //             const SizedBox(height: 5),
                   
              //           ],
              //         ),
              //       // ),
              //       const SizedBox(width: 30),
              //       Container(
              //         width: 200,
              //         padding: EdgeInsets.all(15),
              //         decoration: BoxDecoration(
              //           color: Theme.of(context).brightness == Brightness.dark
              //                ? Colors.grey.shade900
              //                : Colors.white,
              //           border: Border.all(
              //               color: Theme.of(context).brightness == Brightness.dark
              //                    ? Colors.white
              //                    : Colors.black,
              //           ),
              //           borderRadius: BorderRadius.circular(10),
              //         ),
              //         child: Column(
              //           children: [
              //             Text(
              //               "Daily metric card",
              //               style: AppTextstyle.MiniText.copyWith(
              //                 color: Theme.of(context).textTheme.bodyLarge?.color,
              //               ),
              //             ),
              //             const SizedBox(height: 10),
              //             Row(
              //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //               children: [Text("Call handled"), Text("26")],
              //             ),
              //             Row(
              //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //               children: [Text("Conversion"), Text("5")],
              //             ),
              //             Row(
              //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //               children: [Text("Conversion"), Text("5")],
              //             ),
              //           ],
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              SizedBox(height: 30),
              

              Container(
  width: double.infinity,
  padding: const EdgeInsets.all(15),
  decoration: BoxDecoration(
    color: Theme.of(context).brightness ==Brightness.dark
         ? Colors.grey.shade900
         : AppColors.whitetext,
    borderRadius: BorderRadius.circular(20),
  ),

  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [

      
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(
              Icons.call,
              color: AppColors.themeColor,
            ),
          ),

          const SizedBox(width: 15),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  "Call Status Report",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),

                const SizedBox(height: 8),

                Row(
                  children: [

                    Icon(
                      Icons.calendar_today_outlined,
                      size: 16,
                      color: Colors.blueGrey,
                    ),

                    const SizedBox(width: 5),

                    Expanded(
                      child: Text(
                       "Showing $selectedReportType",
                        style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

               
              ],
            ),
          ),

          const SizedBox(width: 10),

          Column(
            children: [
                     PopupMenuButton<String>(
  onSelected: (value) {
    setState(() {
      selectedReportType = value;
    });
  },

  itemBuilder: (context) => [

    const PopupMenuItem(
      value: "Today's data",
      child: Text("Today's data"),
    ),

    const PopupMenuItem(
      value: "Weekly data",
      child: Text("Weekly data"),
    ),

    const PopupMenuItem(
      value: "Monthly data",
      child: Text("Monthly data"),
    ),
  ],

  child: CircleAvatar(
    radius: 22,
    backgroundColor: Colors.blue.shade100,
    child: Icon(
      Icons.filter_list,
      color: AppColors.themeColor,
    ),
  ),
),

              

              const SizedBox(height: 15),

             
            ],
          ),

          const SizedBox(width: 10),

          
   
        ],
      ),
    ],
  ),
),
              const SizedBox(height: 20),
  

  Container(
  width: double.infinity,
  padding: const EdgeInsets.all(20),
  decoration: BoxDecoration(
    color: Theme.of(context).brightness == Brightness.dark
         ? Colors.grey.shade900
         : AppColors.whitetext,
    borderRadius: BorderRadius.circular(25),
    boxShadow: [
      BoxShadow(
        color: Theme.of(context).brightness == Brightness.dark
             ? Colors.black54
             : Colors.grey.shade200,
        blurRadius: 10,
        offset: const Offset(0, 4),
      ),
    ],
  ),

  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [

      /// Header
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          Text(
            "Response Analytics",
            style: AppTextstyle.SubTitle.copyWith(
              color: Theme.of(context).textTheme.bodyLarge?.color,
            )
          ),

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              "Total: 0",
              style: TextStyle(
                color: AppColors.themeColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),

      const SizedBox(height: 30),

      

      SizedBox(
        // height: 200,
        child: Consumer<LeadProvider>(
          builder: (context, pro, child) {
            return Column(
              children: pro.statusCounts.entries.map((entry) {
                String title = entry.key;
                int count = entry.value;

                return analyticsItem(
                  title: title,
                  count: count.toString(),
                  color: Colors.blue,
                );
              }).toList(),
            
          //   ListView.builder(
          // itemCount: pro.statusCounts.length,
          // shrinkWrap: true,
          // physics: NeverScrollableScrollPhysics(),
          // itemBuilder: (context, index) {
        
          //   String title = pro.statusCounts.keys.elementAt(index);
          //   int count = pro.statusCounts.values.elementAt(index);
        
          //   return 
        //     analyticsItem(
        // title: title,
        // count: count.toString(),
        // color: Colors.blue,
        //     )
        //   },
        );
        }),
      ),
      // analyticsItem(
      //   title: "Busy",
      //   count: "0",
      //   color: Colors.lightBlue,
      // ),

      // analyticsItem(
      //   title: "Rejected",
      //   count: "0",
      //   color: Colors.red,
      // ),

      // analyticsItem(
      //   title: "Switched off",
      //   count: "0",
      //   color: Colors.red,
      // ),

      // analyticsItem(
      //   title: "Out of Coverage Area",
      //   count: "0",
      //   color: Colors.green,
      // ),

      // analyticsItem(
      //   title: "Not Attended",
      //   count: "0",
      //   color: Colors.red,
      // ),

      // analyticsItem(
      //   title: "No Status Updated",
      //   count: "0",
      //   color: Colors.purple,
      // ),

      // const SizedBox(height: 20),

     
    ],
  ),
),
const SizedBox(height: 20),

Container(
  width: double.infinity,
  padding: const EdgeInsets.all(15),
  decoration: BoxDecoration(
    color: Theme.of(context).brightness == Brightness.dark
        ? Colors.grey.shade900
        : AppColors.whitetext,
    borderRadius: BorderRadius.circular(20),
  ),

  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [

      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Icon(
              Icons.people,
              color: Colors.green,
            ),
          ),

          const SizedBox(width: 15),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  "Lead Status Report",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.color,
                  ),
                ),

                const SizedBox(height: 8),

                Row(
                  children: [

                    const Icon(
                      Icons.calendar_today_outlined,
                      size: 16,
                      color: Colors.blueGrey,
                    ),

                    const SizedBox(width: 5),

                    Expanded(
                      child: Text(
                        "Showing $selectedReportType",
                        style: const TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),
              ],
            ),
          ),

          const SizedBox(width: 10),

          PopupMenuButton<String>(
            onSelected: (value) {
              setState(() {
                selectedReportType = value;
              });
            },

            itemBuilder: (context) => [

              const PopupMenuItem(
                value: "Today's data",
                child: Text("Today's data"),
              ),

              const PopupMenuItem(
                value: "Weekly data",
                child: Text("Weekly data"),
              ),

              const PopupMenuItem(
                value: "Monthly data",
                child: Text("Monthly data"),
              ),
            ],

            child: CircleAvatar(
              radius: 22,
              backgroundColor: Colors.green.shade100,
              child: const Icon(
                Icons.filter_list,
                color: Colors.green,
              ),
            ),
          ),
        ],
      ),
    ],
  ),
),

const SizedBox(height: 20),

Container(
  width: double.infinity,
  padding: const EdgeInsets.all(20),
  decoration: BoxDecoration(
    color: Theme.of(context).brightness == Brightness.dark
        ? Colors.grey.shade900
        : AppColors.whitetext,
    borderRadius: BorderRadius.circular(25),
    boxShadow: [
      BoxShadow(
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.black54
            : Colors.grey.shade200,
        blurRadius: 10,
        offset: const Offset(0, 4),
      ),
    ],
  ),

  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [

      /// Header
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          Text(
            "Response Analytics",
            style: AppTextstyle.SubTitle.copyWith(
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              "Total Leads: ${allLeads.length}",
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),

      const SizedBox(height: 30),

      analyticsItem(
        title: "New Leads",
        count: "12",
        color: Colors.green,
      ),

      analyticsItem(
        title: "Follow Up",
        count: "8",
        color: Colors.orange,
      ),

      analyticsItem(
        title: "Interested",
        count: "5",
        color: Colors.blue,
      ),

      analyticsItem(
        title: "Converted",
        count: "3",
        color: Colors.purple,
      ),

      analyticsItem(
        title: "Rejected",
        count: "2",
        color: Colors.red,
      ),
    ],
  ),
),
          
                 
               
                
          ]),
      
      ),
    ));
  }
  
}