import 'package:dialo/views/dashboard.dart';
import 'package:dialo/views/repots/reportpage.dart';
import 'package:flutter/material.dart';
import 'package:dialo/constants/app_colors.dart';
import 'leads/addlead.dart';
import 'leads/leads_screen.dart';

class BottomnavPage extends StatefulWidget {
  final Function(bool) changeTheme;
  const BottomnavPage({super.key,required this.changeTheme});

  @override
  State<BottomnavPage> createState() => _BottomnavPageState();
}

class _BottomnavPageState extends State<BottomnavPage> {

  int _currentIndex = 0;

  late final List<Widget>_pages;
  @override
  void initState() {
    super.initState();
    _pages = [
      Dashboard(changeTheme: widget.changeTheme),
      LeadsScreen(changeTheme: widget.changeTheme),
      NewLeadPage(changeTheme: widget.changeTheme),
      Reportpage(changeTheme: widget.changeTheme),
    ];
  }


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
