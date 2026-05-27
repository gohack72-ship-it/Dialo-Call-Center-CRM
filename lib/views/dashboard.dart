import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dialo/providers/leadProvider.dart';
import 'package:dialo/views/settingspage.dart';
// Import to your official lead details screen
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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

    Future.microtask(() async {
      final pro = Provider.of<LeadProvider>(context, listen: false);
      pro.setLoading(true);

      await pro.loadDashboardCounts();
      await pro.getLeadStatus();
      await pro.getStatusCounts();
      pro.getLeads();

      pro.setLoading(false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        toolbarHeight: 50,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(
              Icons.menu,
              color: Theme.of(context).iconTheme.color,
              size: 30,
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        actions: [
          PopupMenuButton<String>(
            icon: Icon(
              Icons.tune,
              color: Theme.of(context).iconTheme.color,
              size: 25,
            ),
           onSelected: (value) {
  final pro = Provider.of<LeadProvider>(context, listen: false);
  
  pro.setLoading(true);
  
  pro.loadDashboardCounts(filter: value).then((_) {
    pro.setLoading(false);
  });
},
            itemBuilder: (context) => [
              const PopupMenuItem(value: "today", child: Text("Today")),
              const PopupMenuItem(value: "week", child: Text("This Week")),
              const PopupMenuItem(value: "month", child: Text("This Month")),
            ],
          ),
        ],
      ),
      drawer: SettingsDrawer(changeTheme: widget.changeTheme),
      body: Consumer<LeadProvider>(
        builder: (context, pro, child) {
          if (pro.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
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
                  Text(
                    "Lead Summary",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 5),
                  Consumer<LeadProvider>(
                    builder: (context, value, child) {
                      return Container(
                        height: MediaQuery.of(context).size.height / 2.5,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListView.separated(
                          itemCount: value.statusList.length,
                          itemBuilder: (context, index) {
                            var status = value.statusList[index];
                            return SummaryRow(
                              title: status,
                              value: (value.leadStatusCountMap[status] ?? 0).toString(),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const Divider(color: Color(0xffEAEAEA));
                          },
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Upcoming Follow-ups",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 15),
                  Consumer<LeadProvider>(
                    builder: (context, provider, child) {
                      // Takes only the top 3 elements
                      final displayLeads = provider.leadList.take(3).toList();

                      if (displayLeads.isEmpty) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Text("No Upcoming Follow-ups found", style: TextStyle(color: Colors.grey)),
                        );
                      }

                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: displayLeads.length,
                        itemBuilder: (context, index) {
                          final currentLead = displayLeads[index];
                          
                          return InkWell(
                            onTap: () async {
                              // Show a loading dialog spinner while fetching full record
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) => const Center(child: CircularProgressIndicator()),
                              );

                              try {
                                String leadId = (currentLead["LEAD_ID"] ?? currentLead["leadId"] ?? currentLead["id"] ?? "").toString();

                                // Backup strategy: If direct ID is missing in memory, resolve document via Phone query
                                if (leadId.isEmpty) {
                                  String phone = (currentLead["PHONE"] ?? currentLead["phone"] ?? "").toString();
                                  if (phone.isNotEmpty) {
                                    var query = await FirebaseFirestore.instance.collection("LEADS").where("PHONE", isEqualTo: phone).get();
                                    if (query.docs.isNotEmpty) {
                                      leadId = query.docs.first.id;
                                    }
                                  }
                                }

                                // Pull fresh, unmodified data payload straight from collection database
                                var docSnapshot = await FirebaseFirestore.instance.collection("LEADS").doc(leadId).get();
                                
                                // Close the processing spinner dialog
                                if (context.mounted) Navigator.pop(context); 

                                if (docSnapshot.exists) {
                                  Map<String, dynamic> fullFirestoreData = docSnapshot.data() as Map<String, dynamic>;
                                  
                                  // Re-inject upper-case structural ID elements required by profile sub-routing
                                  fullFirestoreData["LEAD_ID"] = docSnapshot.id;

                                  if (context.mounted) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => LeadProfileScreen(leadData: fullFirestoreData),
                                      ),
                                    );
                                  }
                                } else {
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text("Error: Unable to locate lead profile details.")),
                                    );
                                  }
                                }
                              } catch (e) {
                                if (context.mounted) Navigator.pop(context); // Fail-safe pop spinner
                                print("Firestore Fetch Exception: $e");
                              }
                            },
                            child: LeadListCard(lead: currentLead),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
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
          const Padding(
            padding: EdgeInsets.only(left: 90),
            child: Icon(Icons.trending_up, color: Colors.black),
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
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
        ],
      ),
    );
  }
}

class LeadListCard extends StatelessWidget {
  final Map<String, dynamic> lead;
  const LeadListCard({super.key, required this.lead});

  @override
  Widget build(BuildContext context) {
    // Flexible mapping lookups to build local card parameters accurately
    final String leadName = (lead["NAME"] ?? lead["name"] ?? "Unknown Lead").toString();
    final String leadStatus = (lead["LEAD_STATUS"] ?? lead["status"] ?? "New").toString();
    final String leadPhone = (lead["PHONE"] ?? lead["phone"] ?? "N/A").toString();
    final String leadPlace = (lead["PLACE"] ?? lead["place"] ?? lead["staff"] ?? "N/A").toString();

    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.grey.shade300,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: const BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  leadName,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: lead["statusColor"] ?? _getStaticStatusColor(leadStatus),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      leadStatus.isNotEmpty ? leadStatus[0] + leadStatus.substring(1).toLowerCase() : leadStatus,
                      style: TextStyle(
                        color: lead["statusText"] ?? Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              const Icon(Icons.phone, color: Colors.blueGrey),
              const SizedBox(width: 10),
              Text(
                leadPhone,
                style: const TextStyle(fontSize: 15),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(Icons.location_on, color: Colors.blueGrey),
              const SizedBox(width: 6),
              Text(
                leadPlace,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(
                Icons.calendar_month,
                color: Colors.orange,
                size: 20,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  (lead["followDate"] ?? lead["ADDED_TIME"] ?? lead["DATE"]) != null
                      ? "Follow up date : ${DateFormat('dd MMM yyyy').format(((lead["followDate"] ?? lead["ADDED_TIME"] ?? lead["DATE"]) as Timestamp).toDate())}"
                      : "No Follow-up Date",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getStaticStatusColor(String currentStatus) {
    switch (currentStatus.toUpperCase()) {
      case "CONVERTED":
        return Colors.green;
      case "FOLLOW UP":
      case "FOLLOW_UP":
        return Colors.blue;
      case "REJECTED":
        return Colors.red;
      case "NEW":
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }
}