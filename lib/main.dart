import 'package:dialo/loginpage.dart';
import 'package:dialo/providers/apiexample.dart';
import 'package:dialo/providers/leadProvider.dart';
<<<<<<< HEAD
import 'package:dialo/providers/loginprovider.dart';
=======
import 'package:dialo/splashScreen.dart';
>>>>>>> 2a0cdb74f49ce5e8b545d58fb1dfb62405d578c1
import 'package:dialo/views/bottomnavigationbar.dart';
import 'package:dialo/views/leads/addlead.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';



// 👈 import your page here

Future<void> main() async {
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
  void initState(){
    super.initState();
    loadTheme();
  }
  void loadTheme()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isDarkMode = prefs.getBool('isDarkMode') ?? false;
    });
  }
  void changeTheme(bool value)async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', value);

    setState(() {
      isDarkMode = value;
    });}

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ 
        ChangeNotifierProvider(create: (_)=>LeadProvider()),
        ChangeNotifierProvider(create: (_)=>Loginprovider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Leads CRM',
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.blue,
          scaffoldBackgroundColor: Colors.white,

          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            elevation: 0,
          ),

          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.blue,

          scaffoldBackgroundColor: const Color(0xff121212),

          appBarTheme: const AppBarTheme(
            backgroundColor: Color.fromARGB(255, 231, 201, 201),
            foregroundColor: Colors.white,
            elevation: 0,
          ),

          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
        ),
        themeMode: isDarkMode?ThemeMode.dark:ThemeMode.light,
<<<<<<< HEAD
        home: Loginpage(),
=======
        home: Splashscreen(changeTheme: (bool p1) {  },),
>>>>>>> 2a0cdb74f49ce5e8b545d58fb1dfb62405d578c1
      ),
    );
  }
}
