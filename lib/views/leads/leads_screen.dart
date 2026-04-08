import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dialo/providers/leadProvider.dart';
import 'package:dialo/views/settingspage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'addlead.dart';
import 'lead_details.dart';

class LeadsScreen extends StatefulWidget {
  final Function(bool) changeTheme;
  const LeadsScreen({super.key, required this.changeTheme});

  @override
  State<LeadsScreen> createState() => _LeadsScreenState();
}

class _LeadsScreenState extends State<LeadsScreen> {
  int currentIndex = 1;
  // STEP 1: Create a variable to hold the currently selected filter
  String selectedStatus = "All";

  @override
  Widget build(BuildContext context) {
    LeadProvider pro = Provider.of<LeadProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,

      drawer: SettingsDrawer(changeTheme: widget.changeTheme),

      endDrawer: const FilterDrawer(),

      appBar: AppBar(
        title: const Text(
          "Leads",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF3F5FBF),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NewLeadPage()),
              );
            },
            child: const Text(
              "Add Lead",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search Leads",
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(vertical: 0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                Builder(
                  builder: (context) => IconButton(
                    icon: const Icon(Icons.tune),
                    onPressed: () {
                      pro.fetchAdditionalLeadDetails();
                      Scaffold.of(context).openEndDrawer();
                    },
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // STEP 2: Update the Chips to react to taps
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                StatusChip(
                  text: "All",
                  isSelected: selectedStatus == "All",
                  onTap: () => setState(() => selectedStatus = "All"),
                ),
                StatusChip(
                  text: "New",
                  isSelected: selectedStatus == "New",
                  onTap: () => setState(() => selectedStatus = "New"),
                ),
                StatusChip(
                  text: "Contacted",
                  isSelected: selectedStatus == "Contacted",
                  onTap: () => setState(() => selectedStatus = "Contacted"),
                ),
                StatusChip(
                  text: "Accepted",
                  isSelected: selectedStatus == "Accepted",
                  onTap: () => setState(() => selectedStatus = "Accepted"),
                ),
                StatusChip(
                  text: "Rejected",
                  isSelected: selectedStatus == "Rejected",
                  onTap: () => setState(() => selectedStatus = "Rejected"),
                ),
                StatusChip(
                  text: "Joined",
                  isSelected: selectedStatus == "Joined",
                  onTap: () => setState(() => selectedStatus = "Joined"),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              // STEP 3: Update the Stream to filter based on 'selectedStatus'
              stream: selectedStatus == "All"
                  ? FirebaseFirestore.instance
                      .collection("LEADS")
                      .orderBy("ADDED_TIME", descending: true)
                      .snapshots()
                  : FirebaseFirestore.instance
                      .collection("LEADS")
                      .where("STATUS", isEqualTo: selectedStatus)
                      .orderBy("ADDED_TIME", descending: true)
                      .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        "Error: ${snapshot.error}\n\nCheck your console for the Index link!",
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  );
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text("No Leads Found"));
                }

                final leads = snapshot.data!.docs;

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: leads.length,
                  itemBuilder: (context, index) {
                    var data = leads[index].data() as Map<String, dynamic>;

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => LeadProfileScreen(
                              leadData: data
                            ),
                          ),
                        );
                      },
                      child: LeadCard(
                        name: data["NAME"] ?? "",
                        phone: data["PHONE"] ?? "",
                        city: data["PLACE"] ?? "",
                        status: data["STATUS"] ?? "New",
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// 🔘 UPDATED STATUS CHIP
class StatusChip extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const StatusChip({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          // If selected, show blue. If not, show light grey.
          color: isSelected ? Colors.blue : const Color(0xFFEAF0F4),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            // If selected, show white text.
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}

// 📋 LEAD CARD (No changes needed here for filtering)
class LeadCard extends StatelessWidget {
  final String name, phone, city, status;

  const LeadCard({
    super.key,
    required this.name,
    required this.phone,
    required this.city,
    required this.status,
  });

  Color getStatusColor() {
    switch (status) {
      case "Accepted":
        return Colors.green;
      case "Contacted":
        return Colors.orange;
      case "Rejected":
        return Colors.red;
      case "Joined":
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Container(
                height: 26,
                width: 90,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: getStatusColor(),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  status,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.phone, size: 16),
              const SizedBox(width: 6),
              Text(phone),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.location_on, size: 16),
              const SizedBox(width: 6),
              Text(city),
            ],
          ),
        ],
      ),
    );
  }
}

// 🎛 FILTER DRAWER (Kept the same for now)
class FilterDrawer extends StatefulWidget {
  const FilterDrawer({super.key});

  @override
  State<FilterDrawer> createState() => _FilterDrawerState();
}

class _FilterDrawerState extends State<FilterDrawer> {
  Map<int, bool> checkedItems = {};

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              "Filters",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Consumer<LeadProvider>(
                builder: (context, val, child) {
                  return ListView.builder(
                    itemCount: val.additionalLeadDetailsList.length,
                    itemBuilder: (context, index) {
                      var item = val.additionalLeadDetailsList[index];
                      return Column(
                        children: [
                          Row(
                            children: [
                              if (item.sub.isEmpty)
                                Checkbox(
                                  value: checkedItems[index] ?? false,
                                  onChanged: (value) {
                                    setState(() {
                                      checkedItems[index] = value!;
                                    });
                                  },
                                ),
                              Text(
                                item.title,
                                style: const TextStyle(fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          if (item.sub.isNotEmpty)
                            _dropdown(null, item.sub, (v) {
                              val.selectedLeadsFilters.add({item.title: v});
                            }),
                          const SizedBox(height: 20),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 120,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Color(0xFF3F5FBF),
                      side: BorderSide.none,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        checkedItems.clear();
                      });
                      Provider.of<LeadProvider>(
                        context,
                        listen: false,
                      ).selectedLeadsFilters.clear();
                    },
                    child: const Text("Reset"),
                  ),
                ),
                SizedBox(width: 10),

                SizedBox(
                  width: 120,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF3F5FBF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      final provider = Provider.of<LeadProvider>(
                        context,
                        listen: false,
                      );
                      print(provider.selectedLeadsFilters);
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Apply",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _dropdown(
    String? value,
    List<String> items,
    ValueChanged<String?> onChanged,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          hint: const Text("Select", style: TextStyle(color: Colors.grey)),
          value: value,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down),
          items: items
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
