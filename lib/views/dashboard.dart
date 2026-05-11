import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dialo/providers/leadProvider.dart';
import 'package:dialo/views/settingspage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/app_colors.dart';
import '../constants/app_textstyle.dart';
import 'leads/lead_details.dart';

class Dashboard extends StatefulWidget {
  final Function(bool) changeTheme;
  const Dashboard({super.key, required this.changeTheme});

  @override
  State<Dashboard> createState() => _DbState();
}

class _DbState extends State<Dashboard> {
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      Provider.of<LeadProvider>(context, listen: false).loadDashboardCounts();
      Provider.of<LeadProvider>(context, listen: false).getLeadStatus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        toolbarHeight: 50,
        backgroundColor:Theme.of(context).appBarTheme.backgroundColor,
        leading: Builder(
          builder: (context) => IconButton(
            icon:  Icon(Icons.menu,
                color: Theme.of(context).iconTheme.color,
                // color: Colors.black,
                size: 30),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),

        // title: Align(
        //   alignment: Alignment.centerRight,
        //   child: const Text(
        //     "HOME PAGE",
        //     style: TextStyle(
        //       color: Colors.black,
        //       fontWeight: FontWeight.bold,
        //       fontSize: 18,
        //     ),
        //   ),
        // ),
        actions: [
          PopupMenuButton<String>(
            icon:  Icon(
              Icons.tune, color: Theme.of(context).iconTheme.color,
                size: 25,
            ),
            onSelected: (value) {
              if (value == "today") {
                print("Today selected");
              } else if (value == "week") {
                print("This week is selected");
              } else if (value == "month") {
                print("This month is selected");
              } else if (value == "overdue") {
                print("Overdue is selected");
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: "today", child: Text("Today")),
              const PopupMenuItem(value: "week", child: Text("This Week")),
              const PopupMenuItem(value: "month", child: Text("This Month")),
              const PopupMenuItem(value: "overdue", child: Text("Over Due")),
            ],
          ),
        ],
      ),
      drawer: SettingsDrawer(changeTheme: widget.changeTheme),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Consumer<LeadProvider>(
                builder: (context1, provider, child) {
                  return GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    childAspectRatio: 1.3,
                    children: [
                      DashboardCard(
                        title: "TOTAL LEADS",
                        value: provider.totalLeads.toString(),
                        color: AppColors.totalLeads,
                      ),
                      DashboardCard(
                        title: "FOLLOW-UPS",
                        value: provider.followUps.toString(),
                        color: AppColors.followUps,
                      ),
                      DashboardCard(
                        title: "TODAY'S CALLS",
                        value: provider.todayCalls.toString(),
                        color: AppColors.todayCalls,
                      ),
                      DashboardCard(
                        title: "OVERDUE",
                        value: provider.overdue.toString(),
                        color: AppColors.overdue,
                      ),
                    ],
                  );
                },
              ),

              const SizedBox(height: 20),
               Text("Lead Summary", style: Theme.of(context).textTheme.titleLarge
              // AppTextstyle.SubTitle
              ),
              const SizedBox(height: 05),
              Consumer<LeadProvider>(
                builder: (context, value, child) {
                  return Container(
                    height: MediaQuery.of(context).size.height / 2,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListView.separated(
                      itemCount: value.statusList.length,
                      itemBuilder: (context, index) {
                        var status = value.statusList[index];
                        print(status);
                        return SummaryRow(title: status, value: "03");
                      },

                      separatorBuilder: (context, index) {
                        return Divider(color: Color(0xffEAEAEA));
                      },
                    ),
                  );
                },
              ),

              const SizedBox(height: 20),
              Text("Upcoming Follow-ups", style: Theme.of(context).textTheme.titleLarge
              // AppTextstyle.SubTitle
              ),
              const SizedBox(height: 15),

              const FollowUpCard(index: 0),
              const FollowUpCard(index: 1),
              const FollowUpCard(index: 1),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: _currentIndex,
      //   type: BottomNavigationBarType.fixed,
      //   selectedItemColor: AppColors.textColor,
      //   unselectedItemColor: AppColors.themeColor,
      //   selectedLabelStyle: const TextStyle(color: AppColors.textColor),
      //   unselectedLabelStyle: const TextStyle(color: AppColors.themeColor),
      //   onTap: (index) {
      //     setState(() {

      //       _currentIndex = index;
      //     });
      //   },
      //   items: const [
      //     BottomNavigationBarItem(icon: Icon(Icons.home), label: "Dashboard"),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.groups_outlined),
      //       label: "Leads",
      //     ),
      //     BottomNavigationBarItem(icon: Icon(Icons.add), label: "Add Lead"),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.receipt_outlined),
      //       label: "Report",
      //     ),
      //   ],
      // ),
    );
  }
}

class DashboardCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;

  const DashboardCard({
    super.key,
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextstyle.dashBoardCard,
          ),
          const SizedBox(height: 8),
          Row(children: [Text(value, style: AppTextstyle.dashBoardCardNo)]),
          Padding(
            padding: EdgeInsets.only(left: 90),
            child:  Icon(Icons.trending_up, color: Colors.black,),
          ),
        ],
      ),
    );
  }
}

class SummaryRow extends StatelessWidget {
  final String title;
  final String value;

  const SummaryRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style:TextStyle(
            color: Theme.of(context).textTheme.bodyLarge?.color,
          // AppTextstyle.normalText
          ),
          ),
          Text(value, style: TextStyle(
            color: Theme.of(context).textTheme.bodyLarge?.color,
          // AppTextstyle.normalText
          ),
          ),
        ],
      ),
    );
  }
}

class FollowUpCard extends StatelessWidget {
  final int index;

  const FollowUpCard({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LeadProfileScreen(leadData: {}),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,

                children: [
                   Text("Mathew", style:TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  // AppTextstyle.NameText
                  ),
                  ),
                  const SizedBox(height: 4),
                  const Text("Check on Proposal View"),
                  const SizedBox(height: 4),
                 Text("Jan-16-2026", style:TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  // AppTextstyle.MicroText
                  ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: index == 0
                    ? Colors.orange.withOpacity(0.15)
                    : Colors.green.withOpacity(0.15),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                index == 0 ? "Contacted" : "Accepted",
                style: TextStyle(
                  color: index == 0 ? Colors.orange : Colors.green,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class SettingsDrawer extends StatefulWidget {
//   final Function(bool)changeTheme;
//   const SettingsDrawer({super.key,required this.changeTheme});
//   @override
//   State<SettingsDrawer> createState() => _SettingsDrawerState();

//   static Widget _item(String title, IconData icon) {
//     return ListTile(
//       leading: Icon(icon, size: 22, color: AppColors.textColor),
//       title: Text(title),
//       onTap: () {},
//     );
//   }
// }

// class _SettingsDrawerState extends State<SettingsDrawer> {
//   bool isDarkMode = false;

//   @override
//   void initState(){
//     super.initState();
//     loadTheme();
//   }

//   void loadTheme()async{
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//       isDarkMode = prefs.getBool('isDarkMode') ?? false;
//     });
//   }

//   void saveTheme(bool value)async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setBool("darkMode", value);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: SafeArea(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 8),
//               child: Row(
//                 children: [
//                   IconButton(
//                     icon: const Icon(Icons.arrow_back, color: Colors.black),
//                     onPressed: () => Navigator.pop(context),
//                   ),
//                   SizedBox(width: 8),
//                   const Text(
//                     "Settings",
//                     style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 20),
//             const ListTile(
//               leading: CircleAvatar(
//                 radius: 24,
//                 backgroundColor: AppColors.themeColor,
//                 child: Icon(
//                   Icons.person_outline,
//                   color:AppColors.textColor ,
//                   size: 28,
//                 ),
//               ),

//               title: Text(
//                 "Profile",
//                 style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22),
//               ),
//             ),
//             SizedBox(height: 10),
//             const Divider(),
//             SettingsDrawer._item("Notifications", Icons.notifications),
//            ListTile(
//              leading: const Icon(Icons.dark_mode,
//                  size: 22,color: AppColors.textColor,),
//              title: const Text("Mode Change"),
//              trailing: Switch(value: isDarkMode,
//                  activeColor: AppColors.themeColor,
//                  onChanged: (value){
//                setState((){
//                  isDarkMode=value;
//                });
//                widget.changeTheme(value);
//                  }),
//            ),
//             SettingsDrawer._item("Help & About", Icons.help),
//             SettingsDrawer._item("Logout", Icons.logout),
//           ],
//         ),
//       ),
//     );
//   }
// }
