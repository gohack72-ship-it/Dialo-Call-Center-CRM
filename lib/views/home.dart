import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class home extends StatelessWidget {
  const home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:Column(

         mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child:AnimatedOpacity(
                opacity: 1.0,
              duration: Duration(seconds: 1),
              child: Image.asset('assets/WhatsApp Image 2026-01-20 at 11.57.03 AM.jpeg',
                fit:BoxFit.contain,height: 400,width: 300,),
      )
          )
        ],
      ),
    );
  }
}
