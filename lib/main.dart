import 'package:dialo/views/addlead.dart';
import 'package:dialo/constants/app_colors.dart';
import 'package:dialo/constants/app_textstyle.dart';
import 'package:dialo/views/bottomnavigationbar.dart';
import 'package:dialo/views/leads_screen.dart';
import 'package:dialo/views/reportpage.dart';



import 'package:flutter/material.dart';

import 'namePage.dart';


// 👈 import your page here

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Leads CRM',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
      ),
      home: BottomnavPage(),
    );
  }
}