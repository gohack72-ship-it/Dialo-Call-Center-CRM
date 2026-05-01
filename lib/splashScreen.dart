import 'dart:async';
import 'package:dialo/providers/leadProvider.dart';
import 'package:dialo/views/bottomnavigationbar.dart';
// import 'package:dialo/views/dashboard.dart';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class Splashscreen extends StatefulWidget {
  final Function(bool) changeTheme;
  const Splashscreen({super.key,required this.changeTheme});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {

  
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // print("ggggggggggggggg");
    context.read<LeadProvider>().loadDashboardCounts();
  Future.delayed(Duration(seconds: 3),(){
                  Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => BottomnavPage(changeTheme: widget.changeTheme),));
                });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(

        child: 
        // showSecond?
         Column(
          mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                          'assets/WhatsApp Image 2026-01-20 at 11.57.03 AM.jpeg',

                          height: 200,
                          width: 200,
                        ),

      Text("Welcome To Dialo",
          style: TextStyle(fontWeight:FontWeight.w900,fontSize: 23 ,color: Colors.blue),)

              ],
            )
        //     : Lottie.asset(
        //   'assets/Loading animation blue.json',
        //   height: 200,
        //   width: 200,
        //   repeat: false,
          
          onLoaded: (composition) {
            Future.delayed(composition.duration, () {
              setState(() {
                showSecond = true;
                Future.delayed(Duration(seconds: 1),(){
                  Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => BottomnavPage(changeTheme: widget.changeTheme),));
                });
              });
            });
          },
        ),
      ),
    );
  }
}