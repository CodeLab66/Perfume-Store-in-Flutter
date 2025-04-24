import 'package:flutter/material.dart';
import 'login_screen.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 90),
            // Logo
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                'assets/images/roselle.png',
                width: MediaQuery.of(context).size.width * 0.15,
                height: MediaQuery.of(context).size.width * 0.15,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 20),
            // Create Account Title
            const Center(
              child: Text(
                'Create Account',
                style: TextStyle(
                  fontSize: 28,
                  fontFamily: 'AnticSlab', // Optional: Use a custom font
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Full Name TextField
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  labelStyle: TextStyle(fontSize: 16, color: Colors.grey),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Email Address TextField
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Email Address',
                  labelStyle: TextStyle(fontSize: 16, color: Colors.grey),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Phone Number TextField
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  labelStyle: TextStyle(fontSize: 16, color: Colors.grey),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Password TextField
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(fontSize: 16, color: Colors.grey),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            // Create Account Button
            ElevatedButton(
              onPressed: () {
                // Add signup functionality
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE8A0A0), // Button color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              child: const Text(
                'Create Account',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            // Already have an account? Login
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Already have an account? ",
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );

                    // Navigate to Login Page
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFFE8A0A0),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
