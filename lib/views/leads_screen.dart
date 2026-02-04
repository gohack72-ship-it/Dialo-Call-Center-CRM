import 'package:flutter/material.dart';

class LeadsScreen extends StatefulWidget {
  const LeadsScreen({super.key});

  @override
  State<LeadsScreen> createState() => _LeadsScreenState();
}

class _LeadsScreenState extends State<LeadsScreen> {
  int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),

    
      endDrawer: const FilterDrawer(),

      body: SafeArea(
        child: Column(
          children: [

            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  const Icon(Icons.arrow_back),
                  const SizedBox(width: 12),
                  const Text("Leads",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  const Spacer(),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text("Add Lead"),
                  ),
                ],
              ),
            ),

            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Builder(
                builder: (context) {
                  return TextField(
                    decoration: InputDecoration(
                      hintText: "Search Leads",
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.tune),
                        onPressed: () {
                          Scaffold.of(context).openEndDrawer();
                        },
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(vertical: 0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 10),

           
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

          
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: const [
                  LeadCard(name: "John", phone: "+1 (555) 123-4567", city: "New York", status: "Accepted"),
                  LeadCard(name: "Emily", phone: "+1 (555) 123-4568", city: "Los Angeles", status: "Contacted"),
                  LeadCard(name: "Sarah", phone: "+1 (555) 123-4568", city: "UK", status: "New"),
                  LeadCard(name: "Michael", phone: "+1 (555) 123-4568", city: "New York", status: "Rejected"),
                  LeadCard(name: "Mathew", phone: "+1 (555) 123-4568", city: "UK", status: "Joined"),
                ],
              ),
            ),
          ],
        ),
      ),

   
      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: _currentIndex,
      //   type: BottomNavigationBarType.fixed,
      //   selectedItemColor: Colors.black,
      //   unselectedItemColor: Colors.grey,
      //   onTap: (index) {
      //     setState(() => _currentIndex = index);
      //   },
      //   // items: const [
        //   BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'),
        //   BottomNavigationBarItem(icon: Icon(Icons.people_outline_rounded), label: 'Leads'),
        //   BottomNavigationBarItem(icon: Icon(Icons.add_outlined), label: 'Add leads'),
        //   BottomNavigationBarItem(icon: Icon(Icons.bar_chart_rounded), label: 'Reports'),
        // ],
      );
    
  }
}



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
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.w500)),
    );
  }
}



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
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const Spacer(),
              Container(
                height: 26,
                width: 90,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: getStatusColor(),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(status,
                    style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(children: const [Icon(Icons.phone, size: 16), SizedBox(width: 6)]),
          Text(phone),
          const SizedBox(height: 4),
          Row(children: const [Icon(Icons.location_on, size: 16), SizedBox(width: 6)]),
          Text(city),
        ],
      ),
    );
  }
}



class FilterDrawer extends StatefulWidget {
  const FilterDrawer({super.key});

  @override
  State<FilterDrawer> createState() => _FilterDrawerState();
}

class _FilterDrawerState extends State<FilterDrawer> {
  String status = "All Status";
  String course = "All Courses";
  String city = "All Cities";

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const Text("Status", style: TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(height: 6),
            _dropdown(status, ["All Status", "New", "Contacted", "Accepted", "Rejected", "Joined"],
                (v) => setState(() => status = v!)),

            const SizedBox(height: 20),
            const Text("Course", style: TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(height: 6),
            _dropdown(course, ["All Courses", "Flutter", "Python"], (v) => setState(() => course = v!)),

            const SizedBox(height: 20),
            const Text("City", style: TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(height: 6),
            _dropdown(city, ["All Cities", "New York", "Los Angeles", "UK", "India"],
                (v) => setState(() => city = v!)),
          ],
        ),
      ),
    );
  }

  Widget _dropdown(String value, List<String> items, ValueChanged<String?> onChanged) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down),
          items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
