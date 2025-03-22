import 'package:flutter/material.dart';
import 'signUp_screen.dart';
import 'ForgetPassword_screen.dart';
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 90.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'assets/images/roselle.png',
                  //borderRadius: BorderRadius.circular(10),
                  width: MediaQuery.of(context).size.width * 0.15,
                  height: MediaQuery.of(context).size.width * 0.15,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Login Title
            const Center(
              child: Text(
                'Login',
                style: TextStyle(
                  fontSize: 28,
                  fontFamily: 'AnticSlab', // Optional: Use a custom font
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
            const SizedBox(height: 10),
            // Forget Password
            Align(
              alignment: Alignment.centerRight,
              child:TextButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ResetPasswordScreen()),
    );
  },
  
                child: const Text(
                  'Forget Password',
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
              ),
            ),
            const SizedBox(height: 10),
            // Login Button
            ElevatedButton(
              onPressed: () {
                // Add login functionality
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE8A0A0), // Button color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              child: const Text(
                'Login',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            // Sign Up Text
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don't have any account? ",
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
                GestureDetector(
                  onTap: () {
                    // Add sign-up navigation
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SignUpScreen()),
              );
            
                  },
                  child: const Text(
                    'Sign Up',
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
