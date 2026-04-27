// 
import 'package:dialo/providers/login_provider.dart';
import 'package:dialo/views/bottomnavigationbar.dart';
import 'package:dialo/views/dashboard.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Loginpage extends StatefulWidget {
  final Function(bool) changeTheme;
  const Loginpage({super.key, required this.changeTheme});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  bool remeberme = false;
  bool obscuretext = true;

  final _formkey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // void loginUser() {
  //   print("✅ Login function called");

  //   ScaffoldMessenger.of(context).showSnackBar(
  //     const SnackBar(
  //       content: Text("Login Successful"),
  //       duration: Duration(seconds: 2),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // 🔥 IMPORTANT (Snackbar issue fix)
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formkey,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [

                    const SizedBox(height: 20),

                    const CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage(
                        "assets/ChatGPT Image Jan 29, 2026, 11_55_11 AM.png",
                      ),
                    ),

                    const SizedBox(height: 30),

                    const Text("Email/User",
                        style: TextStyle(fontWeight: FontWeight.bold)),

                    const SizedBox(height: 8),

                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: "Enter Your Email",
                        prefixIcon: const Icon(Icons.email, color: Colors.blue),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Email is required";
                        }
                        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                            .hasMatch(value)) {
                          return "Enter valid email";
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 20),

                    const Text("Password",
                        style: TextStyle(fontWeight: FontWeight.bold)),

                    const SizedBox(height: 8),

                    TextFormField(
                      controller: passwordController,
                      obscureText: obscuretext,
                      decoration: InputDecoration(
                        hintText: "Enter Password",
                        prefixIcon:
                            const Icon(Icons.lock, color: Colors.blue),
                        suffixIcon: IconButton(
                          icon: Icon(
                            obscuretext
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              obscuretext = !obscuretext;
                            });
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Password required";
                        }
                        if (value.length < 8) {
                          return "Minimum 8 characters";
                        }
                        if (!RegExp(r'[0-9]').hasMatch(value)) {
                          return "Must contain a number";
                        }
                        return null;
                      },
                    ),

                    Row(
                      children: [
                        const Text("Remember Me"),
                        Checkbox(
                          value: remeberme,
                          onChanged: (value) {
                            setState(() {
                              remeberme = value!;
                            });
                          },
                        )
                      ],
                    ),

                    const SizedBox(height: 20),

                    SizedBox(
                      width: 200,
                      height: 45,
                      child: ElevatedButton(
                        onPressed: () {
                          print("🔥 Button Clicked");

                          if (_formkey.currentState!.validate()) {
                            print(" Form Valid");
                            context.read<Loginprovider>().login().then((success) {
                              if (success) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Login Successful"),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        BottomnavPage(changeTheme: widget.changeTheme),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Login Failed"),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              }
                            });
                          } else {
                            print(" Form Invalid");
                          }
                          // Navigator.push(context, MaterialPageRoute(builder: (context) =>  BottomnavPage(changeTheme: widget.changeTheme)));

                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                        ),
                        child: const Text("Login"),
                      ),
                    ),

                    const SizedBox(height: 15),

                    SizedBox(
                      width: 220,
                      height: 45,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          print("Google login clicked");
                        },
                        icon: Image.asset(
                          "assets/googleicon.png",
                          height: 18,
                        ),
                        label: const Text("Login with Google"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}