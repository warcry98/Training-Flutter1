import 'package:flutter/material.dart';
import 'package:login/Screens/logged_user.dart';
import 'package:login/Screens/login_screen.dart';
import 'package:login/Screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/Splash',
      routes: {
        '/Splash': (context) => const SplashScreen(),
        '/Login': (context) => const LoginScreen(),
        '/LoggedUser': (context) => const LoggedUser(),
      },
    );
  }
}
