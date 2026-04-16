import 'package:dialo/providers/loginprovider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  
  bool obscuretext = true;
  final _formkey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    Loginprovider logPro = Provider.of<Loginprovider>(context,listen: false);
    return Scaffold(
     backgroundColor: const Color.fromARGB(255, 255, 255, 255),
     body: Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 50,
          backgroundImage: const AssetImage(
          ("assets/ChatGPT Image Jan 29, 2026, 11_55_11 AM.png"),
          ),
          ),
          Form(
            key:_formkey ,
            child: Column(
           crossAxisAlignment: CrossAxisAlignment.center,
           children: [
           
          const SizedBox(height: 30,),
            const Text(
              "Email/User",
              style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8,),
               Consumer<Loginprovider>(
                 builder: (context1,log,child) {
                   return TextFormField(
                    controller: log.emailController,
                               decoration: InputDecoration(
                                 hintText: "Enter Your Email",
                                 prefixIcon: const Icon(Icons.email_outlined,color: Colors.blue),
                                 border:OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                                 )
                    ),  
                    validator: (value) {
                     if (value == null || value.isEmpty){
                      return "Email is Required";
                     } 
                     if (!value.contains("@")){
                      return "Enter a Valid Email";
                     }
                     return null;
                    },
                             );
                 }
               ),
          const SizedBox(height: 20),
          const Text(
            "Password",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height:8),
          Consumer<Loginprovider>(
            builder: (context2,log1,child) {
              return TextFormField(
                controller: log1.passwordController,
                obscureText: obscuretext,
                decoration: InputDecoration(
                  hintText: "Enter Your Password",
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
                ),
               validator :(value){
                if (value == null || value.isEmpty){
                  return "Password is Required"; 
                }
                if (value.length < 6){
                  return "Password Must be atleast 6 Characters";
                }
                if (! RegExp(r'[0-9]').hasMatch(value)){
                  return "Password Must Contain atleast One Number";
                }
                if (! RegExp(r'[A-Z]').hasMatch(value)){
                  return " Password Must Contain atleast One Uppercase Letter";
                }
                if (! RegExp(r'[a-z]').hasMatch(value)){
                  return "Password Must Contain atleast one Lowercase Letter";
                }
                if (! RegExp(r'[!@#$%^&(),.?:{}|<>]').hasMatch(value)){
                return "Password Must Contain atleast One Special Character";
                }
                return null;
               }
              );
            }
          ),
          Row(
            children: [
              Text("Remember Me",style: TextStyle(color:CupertinoColors.darkBackgroundGray),),
              Consumer<Loginprovider>(
                builder: (context3,log3,child) {
                  return Checkbox(value:log3.remeberme,
                   onChanged: (value){        
                            setState(() {
                     log3.remeberme = value!;
                    });
                   });
                }
              )
            ],
          ),
          const SizedBox(height: 15),
          SizedBox(
            height: 45,
            width: 350,
        child:ElevatedButton(
           style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 21, 115, 192),
            padding: const EdgeInsets.symmetric(vertical:12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            )
           ),

            onPressed: (){
                if (_formkey.currentState!.validate()){
                  print("Login successful");
                }else {
                  print("Validation error");
                }
              }, child:const Text("Log in",style:TextStyle(fontSize:16,fontWeight:FontWeight.bold,color:  Colors.white),)),

          ),
              SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: () {
                 print("Signing in with Google"); 
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/googleicon.png",
                      height:15 ,
                       ),
                       SizedBox(width: 5,),
                    Text("Login with Google",
                          style: TextStyle(fontSize:16, fontWeight:FontWeight.bold ),
                          ),
                          

                  ],
                ),
              ),
             
        ]
            )
            ),
           
],
          )),
    );
  }
}
