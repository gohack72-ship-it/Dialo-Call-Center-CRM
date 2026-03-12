import 'package:flutter/material.dart';


class LeadProfileScreen extends StatefulWidget {
  const LeadProfileScreen({super.key});

  @override
  State<LeadProfileScreen> createState() => _LeadProfileScreenState();
}

class _LeadProfileScreenState extends State<LeadProfileScreen> {
  String? _selectedStatus;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // --- APP BAR ---
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {},
        ),
        title: const Text(
          "Name",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
            child: ElevatedButton.icon(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3F51B5),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12),
              ),
              icon: const Icon(Icons.notifications_active, size: 16),
              label: const Text("set reminder", style: TextStyle(fontSize: 12)),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.edit_square, color: Colors.black54),
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
                  child: _buildPillButton(Icons.phone_in_talk, "Call Now", Colors.black),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildPillButton(Icons.chat_bubble, "Whatsapp", Colors.green),
                ),
              ],
            ),
            const SizedBox(height: 24),

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
            _buildEditableTile(Icons.phone_outlined, "Phone"),
            const SizedBox(height: 10),
            _buildEditableTile(Icons.location_on_outlined, "Location"),
            const SizedBox(height: 20),

            // 5. Lead Details (NOW EDITABLE)
            _buildHeader("Lead Details"),
            _buildEditableTile(Icons.menu_book_outlined, "Education"),
            const SizedBox(height: 10),
            _buildEditableTile(Icons.smartphone_outlined, "Interested Course"),
            const SizedBox(height: 10),
            _buildEditableTile(Icons.calendar_today_outlined, "Create Date"),
            const SizedBox(height: 20),

            // 6. Interaction History
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildHeader("Interaction History", padding: 0),
                const Text("view all >", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
              ],
            ),
            const SizedBox(height: 8),
            Container(
              height: 80,
              decoration: _boxDecoration(),
            ),
            const SizedBox(height: 40),
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
      padding: const EdgeInsets.symmetric(horizontal: 12), // Removed vertical padding
      decoration: _boxDecoration(),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.black87),
          const SizedBox(width: 16),
          // Using Expanded + TextField allows typing
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: hintText,
                border: InputBorder.none, // Removes the line under text
                contentPadding: const EdgeInsets.symmetric(vertical: 14), // Centers text vertically
              ),
              style: const TextStyle(fontSize: 15, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPillButton(IconData icon, String label, Color color) {
    return Container(
      height: 45,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 8),
          Text(label, style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.black87)),
        ],
      ),
    );
  }

  Widget _buildHeader(String title, {double padding = 8.0}) {
    return Padding(
      padding: EdgeInsets.only(bottom: padding),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
      ),
    );
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      color: Colors.white,
      border: Border.all(color: Colors.grey.shade300),
      borderRadius: BorderRadius.circular(10),
    );
  }
}