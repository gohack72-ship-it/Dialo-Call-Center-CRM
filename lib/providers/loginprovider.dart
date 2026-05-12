import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'modelclass.dart';


class Loginprovider extends ChangeNotifier {
bool remeberme = false;

TextEditingController emailController=TextEditingController();
TextEditingController passwordController=TextEditingController();
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
bool get isChecked => remeberme;

Future<auth.User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser =await GoogleSignIn().signIn();

      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth =await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );


      auth.UserCredential userCredential =
      await auth.FirebaseAuth.instance.signInWithCredential(credential);

      return userCredential.user;
    } catch (e) {
      print("Google Sign-In Error: $e");
      return null;
    }
  }
  Future<bool> login() async {
    final prefs = await SharedPreferences.getInstance();

    try {
      print("🔥 Login Function Called");
      print("🔥 Email: ${emailController.text}");
      print("🔥 Password: ${passwordController.text}");

      final querySnapshot = await _firestore
          .collection('AGENT')
          .where('EMAIL', isEqualTo: emailController.text.trim())
          .where('PASSWORD', isEqualTo: passwordController.text.trim())
          .where('ROLE', isEqualTo: 'AGENT')
          .get();

          print("Query Result: ${querySnapshot.docs.length} documents found for email: ${emailController.text.trim()}");

      if (querySnapshot.docs.isNotEmpty) {
        Map<String, dynamic> userMap =
        querySnapshot.docs.first.data();

        SharedPreferences prefs = await SharedPreferences.getInstance();






        print("Login Success: ${emailController.text}");

        await prefs.setBool('remember', isChecked);
        await prefs.setString('email', userMap['EMAIL'] ?? '');
        await prefs.setString('password', userMap['PASSWORD'] ?? '');
        await prefs.setString('employeeid', userMap['EMPLOYEEID'] ?? '');
        await prefs.setString('name', userMap['NAME'] ?? '');
        await prefs.setString('image', userMap['IMAGE'] ?? '');

        // await fetchUsers();
        clearLoginPage();
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

  // void toggleRememberMe(bool value) {
  //   isChecked = value;
  //   notifyListeners();
  //   SharedPreferences.getInstance().then((prefs) {
  //     prefs.setBool('remember', value);
  //     remeberme = value;
  //     notifyListeners();
  //   });
  // }

  void loadRememberMe() {
    SharedPreferences.getInstance().then((prefs) {
      bool remember = prefs.getBool('remember') ?? false;
      emailController.text = remember ? (prefs.getString('email') ?? '') : '';
      passwordController.text = remember ? (prefs.getString('password') ?? '') : '';
      remeberme = remember;
      notifyListeners();
    });
  }

  clearLoginPage() {
    emailController.clear();
    passwordController.clear();
    remeberme = false;
    notifyListeners();
  }

}



