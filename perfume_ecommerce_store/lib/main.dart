import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:perfume_ecommerce_store/screens/index.dart';
import 'screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const Roselle());
}

class Roselle extends StatelessWidget {
  const Roselle({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {'/index': (context) => const HomeScreen()},
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
