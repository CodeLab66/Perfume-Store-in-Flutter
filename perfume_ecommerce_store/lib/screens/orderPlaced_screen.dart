import 'package:flutter/material.dart';
import '../firebase/cart_firebase.dart';
import 'index.dart';

class OrderPlacedScreen extends StatelessWidget {
  const OrderPlacedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Order Placed',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'AnticSlab',
            fontWeight: FontWeight.w600,
            fontSize: 28,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle_outline,
              color: Color(0xFFE8A0A0),
              size: 80,
            ),
            const SizedBox(height: 24),
            const Text(
              'Your order has been placed!',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                fontFamily: 'AnticSlab',
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Thank you for shopping with us.',
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFE8A0A0),
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              onPressed: () async {
                await CartFirebase().clearCart();
                if (context.mounted) {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => const HomeScreen(),
                    ), // or IndexScreen()
                    (route) => false,
                  );
                }
              },
              child: const Text(
                'Continue Shopping',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
