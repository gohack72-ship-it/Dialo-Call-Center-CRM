import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  bool remeberme = false;
  bool obscuretext = true;
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: const Color.fromARGB(255, 255, 255, 255),
     body: Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 50,
          backgroundImage: const AssetImage(
          ("assets/ChatGPT Image Jan 29, 2026, 11_55_11 AM.png"),
          ),
          ),
          Form(child: Column(
            key:_formkey ,
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
           ],
          )),
          const SizedBox(height: 30,),
            const Text(
              "email/user",
              style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8,),
               TextFormField(
            decoration: InputDecoration(
              hintText: "enter your email",
              prefixIcon: const Icon(Icons.email_outlined,color: Colors.blue),
              border:OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              )
                ),  
                validator: (value) {
                 if (value == null || value.isEmpty){
                  return "email is required";
                 } 
                 if (!value.contains("@")){
                  return "enter a valid email";
                 }
                 return null;
                },
          ),
          const SizedBox(height: 20),
          const Text(
            "password",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          TextField(
            obscureText: obscuretext,
            decoration: InputDecoration(
              hintText: "enter your password",
              prefixIcon: const Icon(Icons.lock_outline,color:Colors.blue),
              suffixIcon: IconButton(
              icon: Icon(
                obscuretext ? Icons.visibility_off:Icons.visibility,
                color: Colors.blue.shade800,
              ),               
              onPressed: (){
                setState(() {
                  obscuretext = !obscuretext;
                });
              }, ),
              border:OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ) 
            )
          ),
          Row(
            children: [
              Text("Remember Me",style: TextStyle(color:CupertinoColors.darkBackgroundGray),),
              Checkbox(value:remeberme,
               onChanged: (value){
                setState(() {
                  remeberme = value!;
                });
               })
            ],
          ),
          const SizedBox(height: 10),
          ElevatedButton(
           style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue.shade800,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            )
           ),
            
            onPressed:(){

            }, child: const Text(
              "Log in",
              style:TextStyle(fontSize: 16,color: Colors.white),
            )),
            ElevatedButton(
              onPressed: (){
                if (_formkey.currentState!.validate()){
                  print("Login successful");
                }else {
                  print("validation error");
                }
              }, child:const Text("Log in")),
        ],
     ),
     )
    );
  }
}