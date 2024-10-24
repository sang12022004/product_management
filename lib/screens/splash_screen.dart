import 'dart:async';
import 'package:flutter/material.dart';
import '../theme/colors.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, "/products");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getColor(AppColors.darkBackground),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('images/logo.png', width: 150, height: 150),
            SizedBox(height: 20),
            Text(
              "E-commerce App",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: getColor(AppColors.lightAccent),
              ),
            )
          ],
        ),
      ),
    );
  }
}
