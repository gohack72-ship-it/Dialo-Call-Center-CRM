import 'dart:async';

import 'package:dialo/views/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';


class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}


class _SplashscreenState extends State<Splashscreen> {

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 5), () {

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => home()));

    }
    );

  }

    Widget build(BuildContext context) {
      return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Padding(
              padding: const EdgeInsets.only(left: 150),
              child: SizedBox(height: 200, width: 200,

                  child: Lottie.asset(
                      'assets/Loading animation blue.json'
                  )
              ),
            )
          ],
        ),
      );
    }
  }


