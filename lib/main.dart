// import 'package:dialo/loginpage.dart';

import 'package:dialo/providers/leadProvider.dart';


import 'package:dialo/providers/loginprovider.dart';
<<<<<<< HEAD
import 'package:dialo/splashScreen.dart';
=======
import 'package:dialo/views/bottomnavigationbar.dart';
import 'package:dialo/views/dashboard.dart';
import 'package:dialo/views/leads/addlead.dart';
>>>>>>> 1757d653046e6386a65cd17c9504afd0e057cf26

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = false;

  @override
  void initState() {
    super.initState();
    loadTheme();
  }

  void loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isDarkMode = prefs.getBool('isDarkMode') ?? false;
       
    });
  }

  void changeTheme(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', value);

    setState(() {
      isDarkMode = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ 
        ChangeNotifierProvider(create: (_)=>LeadProvider()),
        ChangeNotifierProvider(create: (_)=>Loginprovider()),
      ],
      child: MaterialApp(
<<<<<<< HEAD
  debugShowCheckedModeBanner: false,
  
  themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
  home: Splashscreen(changeTheme: changeTheme),
)
=======
        debugShowCheckedModeBanner: false,
        themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
        home: BottomnavPage(changeTheme: changeTheme),
      ),
>>>>>>> 1757d653046e6386a65cd17c9504afd0e057cf26
    );
  }
  
 
}