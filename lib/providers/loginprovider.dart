import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Loginprovider extends ChangeNotifier {
bool remeberme = false;

TextEditingController emailController=TextEditingController();
TextEditingController passwordController=TextEditingController();

  get isChecked => null;
  
  get _firestore => null;

  Future<User?> signInWithGoogle() async{
    try {
      final GoogleSignInAccount? googleUser =await GoogleSignIn().signIn();

      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth =await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      
      UserCredential userCredential = 
          await FirebaseAuth.instance.signInWithCredential(credential);

      return userCredential.user;
    } catch (e) {
      print("Google Sign-In Error: $e");
      return null;
    }
  }
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
        Map<String, dynamic> userMap =
        querySnapshot.docs.first.data() as Map<String, dynamic>;

        print("Login Success: ${emailController.text}");

        await prefs.setBool('remember', isChecked);
        await prefs.setString('email', userMap['EMAIL'] ?? '');
        await prefs.setString('password', userMap['PASSWORD'] ?? '');
        await prefs.setString('employeeid', userMap['EMPLOYEEID'] ?? '');
        await prefs.setString('name', userMap['NAME'] ?? '');
        await prefs.setString('image', userMap['IMAGE'] ?? '');

        // await fetchUsers();

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
  Future<void> fetchUsers() async {
}

}



