import 'package:flutter/material.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                'assets/images/roselle.png',
                width: MediaQuery.of(context).size.width * 0.15,
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Rosele',
            style: TextStyle(fontSize: 28, fontFamily: 'AnticSlab'),
          ),
          const SizedBox(height: 20),
          Image.asset(
            'assets/images/getStarted.png',
            height: 400,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              'Experience the Essence of\nLuxury Perfumes',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 19,
                fontFamily: 'AnticSlab',
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              // Add navigation or functionality here
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE8A0A0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
            ),
            child: const Text(
              'Get Started',
              style: TextStyle(
                fontSize: 19,
                fontFamily: 'AnticSlab',
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
