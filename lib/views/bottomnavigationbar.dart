import 'package:dialo/views/leaddetails.dart';
import 'package:dialo/views/reportpage.dart';
import 'package:flutter/material.dart';
import 'package:dialo/constants/app_colors.dart';

class BottomnavPage extends StatefulWidget {
  const BottomnavPage({super.key});

  @override
  State<BottomnavPage> createState() => _BottomnavPageState();
}

class _BottomnavPageState extends State<BottomnavPage> {

  int _currentIndex = 0;

  final List<Widget> _pages = [

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.textColor,
        unselectedItemColor: AppColors.themeColor,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Dashboard",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.groups_outlined),
            label: "Leads",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: "Add Lead",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_outlined),
            label: "Report",
          ),
        ],
      ),
    );
  }
}
