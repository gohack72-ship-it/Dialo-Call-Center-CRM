



import 'package:dialo/views/Name_page.dart';
import 'package:dialo/views/addlead.dart';
import 'package:dialo/views/bottomnavigationbar.dart';
import 'package:dialo/splashScreen.dart';
import 'package:dialo/views/dashboard.dart';
import 'package:dialo/views/home.dart';
import 'package:dialo/views/leads_screen.dart';
import 'package:dialo/views/reportpage.dart';
import 'package:dialo/views/reportsum.dart';
import 'package:flutter/material.dart';



// 👈 import your page here

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = false;
@override
void initState(){
  super.initState();
  loadTheme();
}
void loadTheme()async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  setState(() {
    isDarkMode = prefs.getBool('isDarkMode') ?? false;
  });
}
void changeTheme(bool value)async {
SharedPreferences prefs = await SharedPreferences.getInstance();
await prefs.setBool('isDarkMode', value);

setState(() {
  isDarkMode = value;
});}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Leads CRM',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.blue,
        scaffoldBackgroundColor: Colors.white,

        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
        ),

        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      home: NotificationPage(),
    );
  }
}