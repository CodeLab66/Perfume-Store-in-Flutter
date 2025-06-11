import 'package:flutter/material.dart';
import 'orderPlaced_screen.dart';

class ProcessingPaymentScreen extends StatefulWidget {
  const ProcessingPaymentScreen({super.key});

  @override
  State<ProcessingPaymentScreen> createState() =>
      _ProcessingPaymentScreenState();
}

class _ProcessingPaymentScreenState extends State<ProcessingPaymentScreen> {
  @override
  void initState() {
    super.initState();
    // Simulate payment processing delay, then navigate
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const OrderPlacedScreen()),
        );
      }
    });
  }

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
          'Processing Payment',
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
            const CircularProgressIndicator(
              color: Color(0xFFE8A0A0),
              strokeWidth: 4,
            ),
            const SizedBox(height: 24),
            const Text(
              'Please wait while we deduct money\nfrom your JazzCash account...',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'AnticSlab',
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
