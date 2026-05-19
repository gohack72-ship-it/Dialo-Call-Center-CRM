import 'package:dialo/views/dashboard.dart';
import 'package:dialo/views/repots/reportpage.dart';
import 'package:flutter/material.dart';
import 'package:dialo/constants/app_colors.dart';
import 'package:provider/provider.dart';
import '../providers/leadProvider.dart';
import 'leads/addlead.dart';
import 'leads/leads_screen.dart';

class BottomnavPage extends StatefulWidget {
  final Function(bool) changeTheme;
  const BottomnavPage({super.key, required this.changeTheme});

  @override
  State<BottomnavPage> createState() => _BottomnavPageState();
}

class _BottomnavPageState extends State<BottomnavPage> {
  int _currentIndex = 0;

  late final List<Widget> _pages;
  @override
  void initState() {
    super.initState();
    _pages = [
      Dashboard(changeTheme: widget.changeTheme),
      LeadsScreen(changeTheme: widget.changeTheme),
      NewLeadPage(),
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
        selectedItemColor: Theme.of(context).brightness == Brightness.dark
                         ? Colors.black
                         : Colors.black,
        unselectedItemColor: Theme.of(context).brightness == Brightness.dark
                         ? Colors.white
                         : AppColors.themeColor,

        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          if (index == 2) {
            context.read<LeadProvider>().getLeadStatus();
            context.read<LeadProvider>().fetchAdditionalLeadDetails();
          }
          if (index == 0) {
            context.read<LeadProvider>().getLeadStatus();
          }
          if (index == 3) {
            context.read<LeadProvider>().getCallStatusList();
            context.read<LeadProvider>().getLeadStatus();
            context.read<LeadProvider>().fetchCallStatusCounts();
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Dashboard"),
          BottomNavigationBarItem(
            icon: Icon(Icons.groups_outlined),
            label: "Leads",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: "Add Lead"),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_outlined),
            label: "Report",
          ),
        ],
      ),
    );
  }
}
