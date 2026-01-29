
import 'dart:ffi';

import 'package:flutter/material.dart';

class LeadsScreen extends StatelessWidget {
  const LeadsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          children: [
          
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  const Icon(Icons.menu),
                  const SizedBox(width: 12),
                  const Text(
                    "Leads",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                
                      padding: EdgeInsets.symmetric(horizontal: 12,vertical: 6),
                 
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
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search Leads",
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: const Icon(Icons.tune),
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
                  LeadCard(name: "aysha", phone: "+1 (555) 123-4567", city: "New York", status: "Accepted"),
                  LeadCard(name: "shibin", phone: "+1 (555) 123-4568", city: "Los Angeles", status: "Contacted"),
                  LeadCard(name: "shifa", phone: "+1 (555) 123-4568", city: "UK", status: "New"),
                  LeadCard(name: "risvana", phone: "+1 (555) 123-4568", city: "New York", status: "Rejected"),
                  LeadCard(name: "finiya", phone: "+1 (555) 123-4568", city: "UK", status: "Joined"),
                  LeadCard(name: "swabirin", phone: "+1 (555) 123-4568", city: "India", status: "Joined")
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,blurRadius: 8,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const[Icon(Icons.home_outlined),
              Icon(Icons.people_alt_outlined),
              Icon(Icons.add),
              Icon(Icons.description_outlined),
              ],
            ),
          ),
        ),
      ),
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
  child: Text(
    status,
    textAlign: TextAlign.center,
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
