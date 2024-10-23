import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:pandemonium/api/firebase_api.dart';
import 'package:pandemonium/api/consts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pandemonium/pages/login_pages/login_or_register_page.dart';
import 'firebase_options.dart';
import 'pages/notification_page.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Gemini.init(
    apiKey: GEMINI_API_KEY,
  );
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
    );
  await FirebaseApi().initNotifications();  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoginOrRegisterPage(),
      navigatorKey: navigatorKey,
      routes: {
        '/notification_screen': (context) => const NotificationPage(),
        '/login': (context) => const LoginOrRegisterPage(),
      },
    );
  }
}
