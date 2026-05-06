import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:laptop_harbor_app/features/admin/admin_dashboard.dart';
// import 'package:laptop_harbor_app/features/auth/login_screen.dart';
import 'package:laptop_harbor_app/features/auth/register_screen.dart';
import 'package:laptop_harbor_app/features/home/dashboard.dart';
// import 'package:laptop_harbor_app/features/splash/splash_screen.dart';
import 'package:laptop_harbor_app/firebase_options.dart';

void main() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Dashboard(),
    );
  }
}
