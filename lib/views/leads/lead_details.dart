import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dialo/views/reminderpage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../constants/app_colors.dart';
import '../../providers/leadProvider.dart';

class LeadProfileScreen extends StatefulWidget {
  final Map<String, dynamic> leadData;
  const LeadProfileScreen({super.key, required this.leadData});

  @override
  State<LeadProfileScreen> createState() => _LeadProfileScreenState();
}

class _LeadProfileScreenState extends State<LeadProfileScreen> {
  String? _selectedStatus;

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Map<String, dynamic> extra = widget.leadData["ADDITIONAL_LEAD_DETAILS"] ?? {};

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF121212) : const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        elevation: 0.5,
        centerTitle: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, size: 20, color: Theme.of(context).iconTheme.color),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.leadData["NAME"] ?? "Lead Profile",
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyLarge?.color,
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
        actions: [
          TextButton.icon(
            onPressed: () {
              context.read<LeadProvider>().getCallStatusList();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ReminderPage(leadId: widget.leadData["LEAD_ID"] ?? "")),
              );
            },
            icon: const Icon(Icons.history_rounded, size: 18, color: AppColors.themeColor),
            label: const Text("Follow up", style: TextStyle(color: AppColors.themeColor, fontWeight: FontWeight.bold)),
          ),
          IconButton(
            icon: Icon(Icons.edit_outlined, color: Theme.of(context).iconTheme.color),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- QUICK ACTIONS ---
            Row(
              children: [
                Expanded(
                  child: _buildActionBtn(Icons.phone, "Call", Colors.blue, () => makePhoneCall(widget.leadData["PHONE"] ?? "")),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildActionBtn(Icons.chat_bubble_outline, "WhatsApp", Colors.green, () => openWhatsApp(widget.leadData["PHONE"] ?? "")),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // --- LEAD INFO SECTION ---
            _buildHeader("Lead Details"),
            Container(
              decoration: _boxDecoration(isDark),
              child: Column(
                children: [
                  _buildInfoRow(Icons.person_outline, "Name", widget.leadData["NAME"]),
                  _buildDivider(),
                  _buildInfoRow(Icons.phone_android, "Phone", widget.leadData["PHONE"]),
                  _buildDivider(),
                  _buildInfoRow(Icons.location_on_outlined, "Place", widget.leadData["PLACE"]),
                  _buildDivider(),
                  _buildInfoRow(Icons.email_outlined, "Email", widget.leadData["EMAIL"]),
                  _buildDivider(),
                  _buildInfoRow(Icons.campaign_outlined, "Source", widget.leadData["SOURCE"]),
                ],
              ),
            ),

            // --- ADDITIONAL DETAILS ---
            if (extra.isNotEmpty) ...[
              const SizedBox(height: 24),
              _buildHeader("Additional Details"),
              Container(
                decoration: _boxDecoration(isDark),
                child: Column(
                  children: extra.entries.map((e) {
                    return Column(
                      children: [
                        _buildInfoRow(Icons.read_more, e.key, e.value.toString()),
                        if (e.key != extra.keys.last) _buildDivider(),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ],

            const SizedBox(height: 24),
            _buildHeader("Follow Up History"),

            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("LEADS")
                  .doc(widget.leadData["LEAD_ID"])
                  .collection("FOLLOW_UPS")
                  .orderBy("DATE", descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: Padding(padding: EdgeInsets.all(20), child: CircularProgressIndicator(strokeWidth: 2)));
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Container(
                    padding: const EdgeInsets.all(20),
                    width: double.infinity,
                    decoration: _boxDecoration(isDark),
                    child: const Center(child: Text("No history found", style: TextStyle(color: Colors.grey))),
                  );
                }

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final data = snapshot.data!.docs[index].data() as Map<String, dynamic>;
                    Timestamp? ts = data["DATE"];
                    String dateStr = ts != null ? DateFormat('MMM dd, yyyy • hh:mm a').format(ts.toDate()) : "N/A";

                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(16),
                      decoration: _boxDecoration(isDark),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: AppColors.themeColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(data["LEAD_STATUS"] ?? "No Status",
                                    style: const TextStyle(color: AppColors.themeColor, fontWeight: FontWeight.bold, fontSize: 12)),
                              ),
                              Text(dateStr, style: const TextStyle(color: Colors.grey, fontSize: 11)),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text("Call: ${data["CALL_STATUS"]}", style: const TextStyle(fontWeight: FontWeight.w600)),
                          const SizedBox(height: 4),
                          Text(data["NOTE"] ?? "No notes added", style: TextStyle(color: Colors.grey[600], fontSize: 13)),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // --- UI COMPONENTS ---

  Widget _buildHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 12),
      child: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
    );
  }

  Widget _buildInfoRow(IconData icon, String title, dynamic value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppColors.themeColor.withOpacity(0.7)),
          const SizedBox(width: 12),
          Text("$title:", style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w500)),
          const SizedBox(width: 8),
          Expanded(child: Text(value?.toString() ?? "N/A", style: const TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.end)),
        ],
      ),
    );
  }

  Widget _buildActionBtn(IconData icon, String label, Color color, VoidCallback onTap) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            border: Border.all(color: color.withOpacity(0.5)),
            borderRadius: BorderRadius.circular(12),
            color: color.withOpacity(0.05),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 18),
              const SizedBox(width: 8),
              Text(label, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDivider() => Divider(height: 1, thickness: 0.5, indent: 16, endIndent: 16, color: Colors.grey.withOpacity(0.2));

  BoxDecoration _boxDecoration(bool isDark) {
    return BoxDecoration(
      color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.03),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
      border: Border.all(color: isDark ? Colors.grey.shade800 : Colors.grey.shade200),
    );
  }

  Future<void> makePhoneCall(String phoneNumber) async {
    final Uri url = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(url)) await launchUrl(url);
  }

  Future<void> openWhatsApp(String phone) async {
    final url = Uri.parse("https://wa.me/$phone");
    if (await canLaunchUrl(url)) await launchUrl(url);
  }
}