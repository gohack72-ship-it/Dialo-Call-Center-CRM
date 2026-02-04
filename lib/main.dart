import 'package:dialo/constants/app_colors.dart';
import 'package:dialo/constants/app_textstyle.dart';
import 'package:dialo/views/bottomnavigationbar.dart';
import 'package:dialo/views/leaddetails.dart';
import 'package:dialo/views/reportpage.dart';
import 'package:dialo/views/splash%20screen.dart';
import 'package:flutter/material.dart';
// 👈 import your page here

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: LeadDetails(),
      debugShowCheckedModeBanner: false,
    );
  }
}
