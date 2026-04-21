



// import 'package:dialo/providers/leadProvider.dart';

// import 'package:dialo/views/bottomnavigationbar.dart';

// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'firebase_options.dart';



// // 👈 import your page here

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   runApp(const MyApp());
// }

// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   bool isDarkMode = false;
// @override
// void initState(){
//   super.initState();
//   loadTheme();
// }
// void loadTheme()async{
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   setState(() {
//     isDarkMode = prefs.getBool('isDarkMode') ?? false;
//   });
// }
// void changeTheme(bool value)async {
// SharedPreferences prefs = await SharedPreferences.getInstance();
// prefs.setBool('isDarkMode', value);

// setState(() {
//   isDarkMode = value;
// });}

//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [ ChangeNotifierProvider(create: (_)=>LeadProvider()),],
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         title: 'Leads CRM',
//         theme: ThemeData(
//           brightness: Brightness.light,
//           primaryColor: Colors.blue,
//           scaffoldBackgroundColor: Colors.white,

//           appBarTheme: const AppBarTheme(
//             backgroundColor: Colors.white,
//             foregroundColor: Colors.black,
//             elevation: 0,
//           ),

//           iconTheme: const IconThemeData(
//             color: Colors.black,
//           ),
//         ),
//         darkTheme: ThemeData(
//           brightness: Brightness.dark,
//           primaryColor: Colors.blue,

//           scaffoldBackgroundColor: const Color(0xff121212),

//           appBarTheme: const AppBarTheme(
//             backgroundColor: Color(0xff1E1E1E),
//             foregroundColor: Colors.white,
//             elevation: 0,
//           ),

//           iconTheme: const IconThemeData(
//             color: Colors.white,
//           ),
//         ),
//         themeMode: isDarkMode?ThemeMode.dark:ThemeMode.light,
//         home: BottomnavPage(changeTheme: changeTheme,),
//       ),
//     );
//   }
// }
// import 'package:dialo/providers/leadProvider.dart';
// import 'package:dialo/views/bottomnavigationbar.dart';
// import 'package:flutter/material.dart';

// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';

// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'firebase_options.dart';

// // 🔔 Local Notification Plugin
// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();

// /// 🔥 Background handler (Push notification)
// Future<void> _firebaseBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();
//   print("Background message: ${message.messageId}");
// }

// /// 🔔 Initialize Local Notifications
// Future<void> initLocalNotification() async {
//   const AndroidInitializationSettings androidSettings =
//       AndroidInitializationSettings('@mipmap/ic_launcher');

//   const InitializationSettings settings =
//       InitializationSettings(android: androidSettings);

//   await flutterLocalNotificationsPlugin.initialize( settings: settings);
// }

// /// 🔔 Show Local Notification (used for foreground push also)
// Future<void> showLocalNotification(RemoteMessage message) async {
//   const AndroidNotificationDetails androidDetails =
//       AndroidNotificationDetails(
//     'channel_id',
//     'channel_name',
//     importance: Importance.max,
//     priority: Priority.high,
//   );

//   const NotificationDetails details =
//       NotificationDetails(android: androidDetails);

//   await flutterLocalNotificationsPlugin.show(
//     id: 0,
//     title: message.notification?.title ?? "No Title",
//     body: message.notification?.body ?? "No Body",
//     notificationDetails: details,
//   );
// }

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );

//   /// 🔥 Init Local Notification
//   await initLocalNotification();

//   /// 🔥 Background push setup
//   FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundHandler);

//   runApp(const MyApp());
// }

// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   bool isDarkMode = false;

//   @override
//   void initState() {
//     super.initState();
//     loadTheme();
//     setupFCM(); // 👈 PUSH setup
//   }

//   /// 🔥 Firebase Push Setup
//   void setupFCM() async {
//     FirebaseMessaging messaging = FirebaseMessaging.instance;

//     /// 🔐 Permission
//     await messaging.requestPermission();

//     /// 🆔 Token
//     String? token = await messaging.getToken();
//     print("FCM Token: $token");

//     /// 🟢 Foreground notification
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       print("Foreground message received");

//       /// 👉 Show as local notification
//       showLocalNotification(message);
//     });

//     /// 🔵 When user taps notification
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       print("Notification clicked!");
//     });
//   }

//   void loadTheme() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//       isDarkMode = prefs.getBool('isDarkMode') ?? false;
//     });
//   }

//   void changeTheme(bool value) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setBool('isDarkMode', value);

//     setState(() {
//       isDarkMode = value;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => LeadProvider()),
//       ],
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         title: 'Leads CRM',

//         theme: ThemeData(
//           brightness: Brightness.light,
//           primaryColor: Colors.blue,
//           scaffoldBackgroundColor: Colors.white,
//           appBarTheme: const AppBarTheme(
//             backgroundColor: Colors.white,
//             foregroundColor: Colors.black,
//             elevation: 0,
//           ),
//           iconTheme: const IconThemeData(color: Colors.black),
//         ),

//         darkTheme: ThemeData(
//           brightness: Brightness.dark,
//           primaryColor: Colors.blue,
//           scaffoldBackgroundColor: const Color(0xff121212),
//           appBarTheme: const AppBarTheme(
//             backgroundColor: Color(0xff1E1E1E),
//             foregroundColor: Colors.white,
//             elevation: 0,
//           ),
//           iconTheme: const IconThemeData(color: Colors.white),
//         ),

//         themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
//         home: BottomnavPage(changeTheme: changeTheme),
//       ),
//     );
//   }
// }import 'package:dialo/providers/leadProvider.dart';

import 'package:dialo/BottomnavPage.dart';
import 'package:dialo/notification_service.dart';
import 'package:dialo/providers/leadProvider.dart';
import 'package:dialo/views/bottomnavigationbar.dart';

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
  void initState() {
    super.initState();
    loadTheme();
    setupFCM();

    /// 🔥 App closed → notification click
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        handleNavigation(message);
      }
    });
  }

  /// 🔥 Firebase setup
  void setupFCM() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    await messaging.requestPermission();

    String? token = await messaging.getToken();
    print("FCM Token: $token");

    /// 🟢 Foreground
    FirebaseMessaging.onMessage.listen((message) {
      showLocalNotification(message);
    });

    /// 🔵 Background click
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      handleNavigation(message);
    });
  }

  /// 🚀 Navigation from notification
  void handleNavigation(RemoteMessage message) {
    final data = message.data;

    if (data['type'] == 'lead') {
      navigatorKey.currentState?.push(
        MaterialPageRoute(
          builder: (_) =>  BottomNavPage(items: [],),
        ),
      );
    }
  }

  /// 🌙 Theme load
  void loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isDarkMode = prefs.getBool('isDarkMode') ?? false;
    });
  }

  /// 🌙 Theme change
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
        ChangeNotifierProvider(create: (_) => LeadProvider()),
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
        ),

        themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,

        /// ✅ FIXED HOME
        home:  BottomNavPage(items: [],),
      ),
    );
  }
}