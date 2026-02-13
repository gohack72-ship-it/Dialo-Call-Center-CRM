import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_textstyle.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DbState();
}

class _DbState extends State<Dashboard> {
  int _currentIndex=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFFFFF),
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.black, size: 30),
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
        //       fontWeight: FontWeight.w700,
        //       fontSize: 22,
        //     ),
        //   ),
        // ),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.tune, color: Colors.black, size: 25),
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
      drawer: const SettingsDrawer(),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  childAspectRatio: 1.3,
                  children: const [
                    DashboardCard(
                      title: "TOTAL LEADS",
                      value: "22",
                      color: AppColors.totalLeads,
                    ),
                    DashboardCard(
                      title: "UPCOMING",
                      value: "12",
                      color: AppColors.upcoming,
                    ),
                    DashboardCard(
                      title: "TODAY'S CALLS",
                      value: "08",
                      color: AppColors.todayCalls,
                    ),
                    DashboardCard(
                      title: "OVERDUE",
                      value: "02",
                      color: AppColors.overdue,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                  "Lead Summary",
                  style: AppTextstyle.SubTitle
              ),
              const SizedBox(height: 05),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: const [
                    SummaryRow(title: "New", value: "03"),
                    Divider(color: Color(0xffEAEAEA)),
                    SummaryRow(title: "Contacted", value: "03"),
                    Divider(color: Color(0xffEAEAEA)),
                    SummaryRow(title: "Accepted", value: "03"),
                    Divider(color: Color(0xffEAEAEA)),
                    SummaryRow(title: "Joined", value: "03"),
                    Divider(color: Color(0xffEAEAEA)),
                    SummaryRow(title: "Rejected", value: "03"),
                  ],
                ),
              ),

              const SizedBox(height: 20),
              const Text(
                "Upcoming Follow-ups",
                style: AppTextstyle.SubTitle,
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
              style: AppTextstyle.dashBoardCard
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                  value,
                  style:AppTextstyle.dashBoardCardNo
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: 90),
            child: const Icon(Icons.trending_up),
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
          Text(title, style: AppTextstyle.normalText),
          Text(value, style: AppTextstyle.normalText),
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
    return Container(
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
                const Text(
                    "Mathew",
                    style: AppTextstyle.NameText
                ),
                const SizedBox(height: 4),
                const Text("Check on Proposal View"),
                const SizedBox(height: 4),
                const Text(
                    "Jan-16-2026",
                    style:AppTextstyle.MicroText
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
    );
  }
}

class SettingsDrawer extends StatelessWidget {
  const SettingsDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () => Navigator.pop(context),
                  ),
                  SizedBox(width: 8),
                  const Text(
                    "Settings",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            const ListTile(
              leading: CircleAvatar(
                radius: 24,
                backgroundColor: AppColors.themeColor,
                child: Icon(
                  Icons.person_outline,
                  color:AppColors.textColor ,
                  size: 28,
                ),
              ),

              title: Text(
                "Profile",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22),
              ),
            ),
            SizedBox(height: 10),
            const Divider(),
            _item("Notifications", Icons.notifications),
            _item("Appearance", Icons.palette),
            _item("Help & About", Icons.help),
            _item("Logout", Icons.logout),
          ],
        ),
      ),
    );
  }

  static Widget _item(String title, IconData icon) {
    return ListTile(
      leading: Icon(icon, size: 22, color: AppColors.textColor),
      title: Text(title),
      onTap: () {},
    );
  }
}
