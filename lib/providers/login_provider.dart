import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Loginprovider extends ChangeNotifier{
  bool isChecked = false;
  bool isPasswordHidden = true;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // List<Usermodel> userList = [];

  Future<bool> login() async {
    final prefs = await SharedPreferences.getInstance();

    try {
      final querySnapshot = await _firestore
          .collection('AGENT')
          .where('EMAIL', isEqualTo: emailController.text.trim())
          .where('PASSWORD', isEqualTo: passwordController.text.trim())
          .where('ROLE', isEqualTo: 'AGENT')
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        Map<String, dynamic> userMap =querySnapshot.docs.first.data();

        print("Login Success: ${emailController.text}");

        await prefs.setBool('remember', isChecked);
        await prefs.setString('email', userMap['EMAIL'] ?? '');
        await prefs.setString('password', userMap['PASSWORD'] ?? '');
        await prefs.setString('employeeid', userMap['EMPLOYEEID'] ?? '');
        await prefs.setString('name', userMap['NAME'] ?? '');
        await prefs.setString('image', userMap['IMAGE'] ?? '');

        

        return true;
      } else {
        print("Login Failed: Invalid credentials");
        return false;
      }
    } catch (e) {
      print("Unexpected Error: $e");
      return false;
    }
  }
}