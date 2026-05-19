import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dialo/views/reminderpage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../constants/app_colors.dart';
import '../../providers/leadProvider.dart';
import 'package:flutter/services.dart';

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

    Map<String, dynamic> extra =
        widget.leadData["ADDITIONAL_LEAD_DETAILS"] ?? {};
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      // --- APP BAR ---
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon:  Icon(Icons.arrow_back, color:Theme.of(context).iconTheme.color),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(widget.leadData["NAME"] ?? "Name", style: TextStyle(
          color: Theme.of(context).textTheme.bodyLarge?.color,
          fontWeight: FontWeight.bold,
          fontSize: 22,
        ),

        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
            child: ElevatedButton.icon(
              onPressed: () {
                context.read<LeadProvider>().getCallStatusList();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ReminderPage(leadId: '',),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.themeColor,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12),
              ),
              icon: Padding(
                padding: const EdgeInsets.all(0.0),
                child: const Icon(Icons.notifications_active, size: 16),
              ),
              label: const Text("Follow up", style: TextStyle(fontSize: 11)),
            ),
          ),
          IconButton(
            icon:  Icon(Icons.edit_square, color:Theme.of(context).iconTheme.color),
            onPressed: () {},
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: Colors.grey[200], height: 1.0),
        ),
      ),

      // --- BODY ---
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Top Buttons
            Row(
              children: [
                Expanded(
                  child: _buildPillButton(
                    Icons.phone_in_talk,
                    "Call Now",
                    Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                        () {
                      String phone = widget.leadData["PHONE"] ?? "";
                      if (phone.isNotEmpty) {
                        makePhoneCall(phone);
                      } else {
                        print("No phone number");
                      }
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildPillButton(
                    Icons.chat_bubble,
                    "Whatsapp",
                      Colors.green,
                        () async {
                      String phone = widget.leadData["PHONE"] ?? "";
                      final url = Uri.parse("https://wa.me/$phone");

                      if (await canLaunchUrl(url)) {
                        await launchUrl(url);
                      } else {
                        print("WhatsApp not available");
                      }
                    },
                  ),
                ),
              ],
            ),
           SizedBox(height: 10,),
            Text(
                "Name",
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
            ),
            _buildEditableTile(
              Icons.person_outline_outlined,
              widget.leadData["NAME"] ?? "",
            ),

            SizedBox(height: 10,),
            Text("Place"),
            _buildEditableTile(
              Icons.place,
              widget.leadData["PLACE"] ?? "",
            ),
            SizedBox(height: 10,),
            Text("Email"),
            _buildEditableTile(
              Icons.mail,
              widget.leadData["EMAIL"] ?? "",
            ),
            SizedBox(height: 10,),
            Text("Sourse"),
            _buildEditableTile(
              Icons.source,
              widget.leadData["SOURCE"] ?? "",
            ),
            const SizedBox(height: 20),

            _buildHeader("Additional Details"),

            Column(
              children: extra.entries.map((e) {
                print(widget.leadData);
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(e.key),
                    _buildEditableTile(Icons.read_more_rounded, e.value.toString()),
                    const SizedBox(height: 10),

                  ],
                );
              }).toList(),

            ),


            SizedBox(height: 10,),
            // 2. Status
            _buildHeader("Status"),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: _boxDecoration(),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isExpanded: true,
                  hint: const Text("Select Status"),
                  value: _selectedStatus,
                  icon: const Icon(Icons.arrow_drop_down),
                  items: ["New", "Interested", "Follow Up"]
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (val) {
                    setState(() => _selectedStatus = val);
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),

            // 3. Interaction
            _buildHeader("Interaction"),
            Container(
              height: 100,
              decoration: _boxDecoration(),
              child: const TextField(
                maxLines: null,
                decoration: InputDecoration(
                  hintText: "Type interaction notes...",
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(12),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // 4. Contact Information (NOW EDITABLE)
            _buildHeader("Contact Information"),
            _buildEditableTile(
              Icons.phone_outlined,
              widget.leadData["PHONE"] ?? "",
            ),
            // const SizedBox(height: 10),
            // _buildEditableTile(
            //   Icons.location_on_outlined,
            //   widget.leadData["PLACE"] ?? "",
            // ),
            // const SizedBox(height: 20),



            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     _buildHeader("Interaction History", padding: 0),
            //     const Text(
            //       "view all >",
            //       style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            //     ),
            //   ],
            // ),
            // const SizedBox(height: 8),
            // Container(height: 80, decoration: _boxDecoration()),
            // const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // --- REUSABLE WIDGETS ---

  // 1. UPDATED: Editable Text Field (Previously read-only)
  Widget _buildEditableTile(IconData icon, String hintText) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
      ), // Removed vertical padding
      decoration: _boxDecoration(),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Theme.of(context).iconTheme.color),
          const SizedBox(width: 16),
          // Using Expanded + TextField allows typing
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
                border: InputBorder.none, // Removes the line under text
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 14,
                ), // Centers text vertically
              ),
              style:  TextStyle(fontSize: 15, color: Theme.of(context).textTheme.bodyLarge?.color),
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildPillButton(
      IconData icon,
      String label,
      Color color,
  VoidCallback onTap
      ) {
    return GestureDetector(
      onTap: onTap, // 👈 handle click
      child:Container(
      height: 45,
      decoration: BoxDecoration(
        border: Border.all(
            color: Theme.of(context).brightness == Brightness.dark
                 ? Colors.grey.shade700
                 : Colors.grey.shade300
          ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
            ),
          ],
        ),
      ),
    );
  }
  Future<void> makePhoneCall(String phoneNumber) async {
    final Uri url = Uri(scheme: 'tel', path: phoneNumber);

    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      print("Could not launch $url");
    }
  }


  Widget _buildHeader(String title, {double padding = 8.0}) {
    return Padding(
      padding: EdgeInsets.only(bottom: padding),
      child: Text(
        title,
        style:  TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).textTheme.bodyLarge?.color,
        ),
      ),
    );
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      color: Theme.of(context).brightness == Brightness.dark
             ? const Color(0xFF1E1E1E)
             : Colors.white,
      border: Border.all(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.grey.shade700
              : Colors.grey.shade300
      ),
      borderRadius: BorderRadius.circular(10),
    );
  }
}



