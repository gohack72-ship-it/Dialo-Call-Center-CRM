import 'package:flutter/material.dart';
import 'home_page.dart';
import 'schedule_page.dart' hide HomePage;

class BottomNavPage extends StatefulWidget {
  const BottomNavPage({super.key, required List items});

  @override
  State<BottomNavPage> createState() => _BottomNavPageState();
}

class _BottomNavPageState extends State<BottomNavPage> {
  int currentIndex = 0;

  final List<Widget> pages = [
    const HomePage(),
    const SchedulePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            label: "Schedule",
          ),
        ],
      ),
    );
  }
}