import 'dart:developer';

import 'package:dialo/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // <--- added

class Signuppage extends StatefulWidget {
  const Signuppage({super.key});

  @override
  State<Signuppage> createState() => _SignuppageState();
}

class _SignuppageState extends State<Signuppage> {
  final _signupKey = GlobalKey<FormState>();

  String selectGender = "";
  bool _obscurePassword = true;
  bool isChecked = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();

  final usernameReg = RegExp(r'^[a-zA-Z]{5,10}$');
  final emailReg = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w{2,}$');
  final passwordReg = RegExp(r'^(?=.*[0-9]).{7,}$');
  final dobReg = RegExp(r'^\d{1,2}/\d{1,2}/\d{4}$');

  // SAVE DATA TO SHARED PREFERENCES
  Future<void> saveData() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString("name", _nameController.text);
    await prefs.setString("email", _emailController.text);
    await prefs.setString("gender", selectGender);
    await prefs.setString("dob", _dobController.text);

    debugPrint("Saved!");
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _dobController.dispose();
    super.dispose();
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        height: double.infinity,
        child: Form(
          key: _signupKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 40),
                const Text(
                  "SignUp Now",
                  style: TextStyle(fontSize: 30, color: Colors.black),
                ),
                const SizedBox(height: 30),

                // USERNAME
                TextFormField(
                  style: const TextStyle(color: Colors.black),
                  validator: (value) {
                    if (!usernameReg.hasMatch(value!)) {
                      return "Username must be 5–10 letters";
                    }
                    return null;
                  },
                  controller: _nameController,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(20),
                    hintText: "Username",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // EMAIL
                TextFormField(
                  style: const TextStyle(color: Colors.black),
                  validator: (value) {
                    if (!emailReg.hasMatch(value!)) {
                      return "Enter a valid email";
                    }
                    return null;
                  },
                  controller: _emailController,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(20),
                    hintText: "Email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // PASSWORD
                TextFormField(
                  style: const TextStyle(color: Colors.black),
                  validator: (value) {
                    if (!passwordReg.hasMatch(value!)) {
                      return "Password must have 7 characters & a number";
                    }
                    return null;
                  },
                  obscureText: _obscurePassword,
                  controller: _passwordController,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(20),
                    hintText: "Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // GENDER TITLE
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Select Gender",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),

                // GENDER OPTIONS
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        Radio(
                          value: "Male",
                          groupValue: selectGender,
                          onChanged: (value) {
                            setState(() {
                              selectGender = value.toString();
                            });
                          },
                        ),
                        const Text("Male"),
                      ],
                    ),
                    Row(
                      children: [
                        Radio(
                          value: "Female",
                          groupValue: selectGender,
                          onChanged: (value) {
                            setState(() {
                              selectGender = value.toString();
                            });
                          },
                        ),
                        const Text("Female"),
                      ],
                    ),
                    Row(
                      children: [
                        Radio(
                          value: "Other",
                          groupValue: selectGender,
                          onChanged: (value) {
                            setState(() {
                              selectGender = value.toString();
                            });
                          },
                        ),
                        const Text("Other"),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // DOB TITLE
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "DOB",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 20),

                // DOB FIELD WITH DATE PICKER
                TextFormField(
                  style: const TextStyle(color: Colors.black),
                  validator: (value) {
                    if (!dobReg.hasMatch(value!)) {
                      return "Invalid Format — Use DD/MM/YYYY";
                    }
                    return null;
                  },
                  controller: _dobController,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(20),
                    hintText: "D/M/Y",
                    labelText: "Date Of Birth",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.calendar_today, color: Colors.black),
                      onPressed: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        );

                        if (pickedDate != null) {
                          _dobController.text =
                          "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                        }
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // CHECKBOX
                Row(
                  children: [
                    Checkbox(
                        value: isChecked,
                        onChanged: (newValue) {
                          setState(() {
                            isChecked = newValue!;
                          });
                        }),
                    const Expanded(
                      child: Text(
                          "I would like to receive your newsletter and promotional info"),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // SIGN UP BUTTON
                ElevatedButton(
                  onPressed: () async {
                    log("clicked");
                    if (_signupKey.currentState!.validate()) {
                      if (selectGender == "") {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Please select gender")),
                        );
                        return;
                      }

                      await saveData();

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Sign Up Successful")),
                      );

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => Loginpage()),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    "Sign up",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}