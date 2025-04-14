import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const Roselle());
}

class Roselle extends StatelessWidget {
  const Roselle({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ROSELLE App',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
