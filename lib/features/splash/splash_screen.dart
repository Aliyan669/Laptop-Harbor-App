import 'dart:async';

import 'package:flutter/material.dart';
import 'package:laptop_harbor_app/features/home/home_screen.dart';
import 'package:laptop_harbor_app/features/onboarding/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  islogin() {
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OnboardingScreen()),
      );
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    islogin();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Icon(Icons.shopify_rounded, size: 40, color: Colors.lightGreen),
      ),
    );
  }
}
