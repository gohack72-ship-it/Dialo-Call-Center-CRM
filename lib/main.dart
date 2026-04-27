import 'package:dialo/loginpage.dart';




import 'package:dialo/providers/leadProvider.dart';


import 'package:dialo/notification_service.dart';
import 'package:dialo/providers/leadProvider.dart';
import 'package:dialo/providers/loginprovider.dart';
import 'package:dialo/views/bottomnavigationbar.dart';
import 'package:dialo/views/leads/addlead.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';

/// 🔑 Navigator key
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

/// 🔔 Local Notification Plugin
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

/// 🔥 Background handler
Future<void> _firebaseBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

/// 🔔 Init Local Notification
Future<void> initLocalNotification() async {
  const androidSettings =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const settings = InitializationSettings(android: androidSettings);

  await flutterLocalNotificationsPlugin.initialize(settings: 
    settings,
    onDidReceiveNotificationResponse: (response) {
      /// 🔥 Notification click handle
      navigatorKey.currentState?.push(
        MaterialPageRoute(
          builder: (_) =>  BottomNavigationBar(items: [],),
        ),
      );
    },
  );
}

/// 🔔 Show Local Notification
Future<void> showLocalNotification(RemoteMessage message) async {
  const androidDetails = AndroidNotificationDetails(
    'channel_id',
    'channel_name',
    importance: Importance.max,
    priority: Priority.high,
  );

  await flutterLocalNotificationsPlugin.show(
    id: 0,
    title: message.notification?.title ?? "No Title",
    body: message.notification?.body ?? "No Body",
    payload: message.data.toString(),
    notificationDetails: NotificationDetails(android: androidDetails),
  );
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await NotificationService.init();
  
  await initLocalNotification();

  FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundHandler);

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
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'Leads CRM',

        theme: ThemeData(
          brightness: Brightness.light,
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
        home: Loginpage(changeTheme: changeTheme,),
      ),
    );
  }
}