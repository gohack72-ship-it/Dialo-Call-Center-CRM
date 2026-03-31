import 'package:dialo/providers/leadProvider.dart';
import 'package:dialo/views/settingspage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LeadsScreen extends StatefulWidget {
  final Function(bool) changeTheme;
  const LeadsScreen({super.key, required this.changeTheme});

  @override
  State<LeadsScreen> createState() => _LeadsScreenState();
}

class _LeadsScreenState extends State<LeadsScreen> {
  int _currentIndex = 1;

  @override
  void initState() {
    super.initState();

    // ✅ FETCH DATA
    Future.microtask(() =>
        Provider.of<LeadProvider>(context, listen: false).fetchLeads());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      drawer: SettingsDrawer(changeTheme: widget.changeTheme),

      appBar: AppBar(
        title: const Text(
          "Leads",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            onPressed: () {},
            child: const Text("Add Lead"),
          ),
          const SizedBox(width: 10),
        ],
      ),

      body: Column(
        children: [
          // 🔍 SEARCH
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
                      contentPadding:
                      const EdgeInsets.symmetric(vertical: 0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // 🔘 STATUS CHIPS
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: const [
                StatusChip(text: "New"),
                StatusChip(text: "Contacted"),
                StatusChip(text: "Accepted"),
                StatusChip(text: "Rejected"),
                StatusChip(text: "Joined"),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // 📋 LIST
          Expanded(
            child: Consumer<LeadProvider>(
              builder: (context1, pro, child) {
                // ✅ DEBUG
                print("Leads count: ${pro.leadsList.length}");

                // ✅ LOADING STATE
                if (pro.leadsList.isEmpty) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return ListView.builder(
                  itemCount: pro.leadsList.length,
                  itemBuilder: (context, index) {
                    var lead = pro.leadsList[index];

                    return LeadCard(
                      name: lead["name"] ?? "",
                      phone: lead["phone"] ?? "",
                      city: lead["place"] ?? "",
                      status: lead["status"] ?? "New",
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

// 🔘 STATUS CHIP
class StatusChip extends StatelessWidget {
  final String text;
  const StatusChip({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF0F4),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
    );
  }
}

// 📋 LEAD CARD
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
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4),
        ],
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
            children: const [
              Icon(Icons.phone, size: 16),
              SizedBox(width: 6),
            ],
          ),
          Text(phone),

          const SizedBox(height: 4),

          Row(
            children: const [
              Icon(Icons.location_on, size: 16),
              SizedBox(width: 6),
            ],
          ),
          Text(city),
        ],
      ),
    );
  }
}