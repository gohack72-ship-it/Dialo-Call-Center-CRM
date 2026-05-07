import 'package:dialo/constants/app_colors.dart';
import 'package:dialo/constants/app_textstyle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/leadProvider.dart';


import 'package:dialo/views/repots/reportsum.dart';
import 'package:dialo/views/settingspage.dart';


class Reportpage extends StatefulWidget {
  final Function(bool) changeTheme;
  const Reportpage({super.key,required this.changeTheme});

  @override
  State<Reportpage> createState() => _ReportpageState();
}

class _ReportpageState extends State<Reportpage> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      Provider.of<LeadProvider>(context, listen: false)
          .calculateWorkload();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whitetext,
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
                     SettingsDrawer(changeTheme:widget.changeTheme),
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
                  filled: true,
                  fillColor: AppColors.themeColor,
                  hintText: "search leads",
                  hintStyle: TextStyle(color: AppColors.whitetext),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: AppColors.whitetext,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Text("Summary card", style: AppTextstyle.SubTitle),
              const SizedBox(height: 30),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Container(
                      width: 200,
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: AppColors.whitetext,
                        border: Border.all(color: AppColors.textColor),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [

                          // ... inside your Row's children, replace the first Container with this:

                          Container(
                            width: 200,
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: AppColors.whitetext,
                              border: Border.all(color: AppColors.textColor),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  "Today's workload",
                                  style: AppTextstyle.MiniText,
                                ),
                                const SizedBox(height: 10),

                                // Dynamic Data Section
                                Consumer<LeadProvider>(
                                  builder: (context, provider, child) {
                                    return Column(
                                      children: [
                                        Text(
                                          "${provider.dueToday}",
                                          style: const TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.themeColor
                                          ),
                                        ),
                                        const Text("Leads Due Today", style: TextStyle(fontSize: 10)),
                                      ],
                                    );
                                  },
                                ),

                                const SizedBox(height: 15),

                                // Comparison Row
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const Text("This week", style: TextStyle(fontSize: 12)),
                                    Consumer<LeadProvider>(
                                      builder: (context, provider, child) {
                                        return Text(
                                          "${provider.thisWeek}",
                                          style: const TextStyle(fontWeight: FontWeight.bold),
                                        );
                                      },
                                    ),
                                    const CircleAvatar(
                                      radius: 5,
                                      backgroundColor: AppColors.themeColor,
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 10),

                                // View Button
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black12),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => const ReportSum(),
                                        ),
                                      );
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: const [
                                        Padding(
                                          padding: EdgeInsets.symmetric(vertical: 4),
                                          child: Text(
                                            "View detailed report",
                                            style: TextStyle(fontSize: 10),
                                          ),
                                        ),
                                        Icon(Icons.arrow_forward, size: 14),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 5),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "View all reports",
                                  style: TextStyle(fontSize: 10),
                                ),
                                IconButton(
                                  icon: Icon(Icons.arrow_forward),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => ReportSum(),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 30),
                    Container(
                      width: 200,
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: AppColors.whitetext,
                        border: Border.all(color: AppColors.textColor),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Text(
                            "Daily metric card",
                            style: AppTextstyle.MiniText,
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [Text("Call handled"), Text("26")],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [Text("Conversion"), Text("5")],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [Text("Conversion"), Text("5")],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              Text("Report feed", style: AppTextstyle.title),
              const SizedBox(height: 50),
              Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.textColor),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Alice cooper", style: AppTextstyle.SubTitle),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: 20,
                              width: 80,
                              decoration: BoxDecoration(
                                color: AppColors.redColor,
                              ),
                              child: Row(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Overdue",
                                        style: TextStyle(
                                          color: AppColors.whitetext,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 4),
                                  Icon(
                                    Icons.warning_amber,
                                    color: AppColors.whitetext,
                                    size: 18,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text("Priority:"),
                            const SizedBox(width: 10),
                            CircleAvatar(
                              radius: 5,
                              backgroundColor: AppColors.redColor,
                            ),
                            Text("High"),
                          ],
                        ),
                        Row(
                          children: [
                            Text("Handle Time:"),
                            Text("5m 20s"),
                            Spacer(),
                            Container(
                              height: 25,
                              width: 50,
                              decoration: BoxDecoration(
                                color: AppColors.redColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.call_end,
                                    color: AppColors.whitetext,
                                    size: 20,
                                  ),
                                  Text(
                                    "Call",
                                    style: TextStyle(
                                      color: AppColors.whitetext,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.textColor),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text("Swabirin", style: AppTextstyle.SubTitle),
                            Spacer(),
                            Row(
                              children: [
                                Icon(
                                  Icons.check_box_outlined,
                                  color: AppColors.greenColor,
                                ),
                                Text(
                                  "Completed",
                                  style: TextStyle(color: AppColors.greenColor),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 10,
                              backgroundColor: AppColors.themeColor,
                              child: CircleAvatar(
                                radius: 5,
                                backgroundColor: AppColors.whitetext,
                              ),
                            ),
                            Text("Pending", style: AppTextstyle.MiniText),
                          ],
                        ),
                        Row(
                          children: [
                            Text("priority:"),
                            CircleAvatar(
                              radius: 5,
                              backgroundColor: AppColors.redColor,
                            ),
                            Text("High"),
                          ],
                        ),
                        Row(
                          children: [
                            Text("Handle time:"),
                            Text("3m 32s"),
                            Spacer(),
                            Container(
                              height: 25,
                              width: 50,
                              decoration: BoxDecoration(
                                color: AppColors.greenColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.call_end,
                                    color: AppColors.whitetext,
                                    size: 20,
                                  ),

                                  Text(
                                    "Call",
                                    style: TextStyle(
                                      color: AppColors.whitetext,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
