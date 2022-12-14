import 'dart:async';

import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    startTime();
  }

  startTime() async {
    var timeLoad = const Duration(seconds: 3);
    return Timer(timeLoad, navigationPage);
  }

  void navigationPage() {
    Navigator.pushNamed(context, '/Login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'images/logo.png',
              height: 120,
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: CircularProgressIndicator(),
            ),
          ],
        ),
      ),
    );
  }
}
