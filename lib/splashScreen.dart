import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {

  bool showSecond = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(

        child: showSecond
            ? Image.asset(
          'assets/WhatsApp Image 2026-01-20 at 11.57.03 AM.jpeg',

          height: 200,
          width: 200,
        )
            : Lottie.asset(
          'assets/Loading animation blue.json',
          height: 200,
          width: 200,
          repeat: false,
          onLoaded: (composition) {
            Future.delayed(composition.duration, () {
              setState(() {
                showSecond = true;

              });
            });
          },
        ),
      ),
    );
  }
}