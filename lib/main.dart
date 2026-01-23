import 'package:dialo/addlead.dart';
import 'package:dialo/splash%20screen.dart';
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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home:NewLeadPage(), // 👈 this is your home page
      debugShowCheckedModeBanner: false,
    );
  }
}
