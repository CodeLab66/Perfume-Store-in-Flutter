import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../firebase/cart_firebase.dart';
import 'cart_screen.dart';
import 'orderPlaced_screen.dart';
import 'paymentProcessing_screen.dart';

class CheckoutScreen extends StatefulWidget {
  final CartFirebase cartFirebase = CartFirebase();

  CheckoutScreen({super.key});

  static const Color pinkColor = Color(0xFFE8A0A0);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String selectedPaymentMethod = 'cash';

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDoc() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    return FirebaseFirestore.instance.collection('users').doc(uid).get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Checkout',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'AnticSlab',
            fontWeight: FontWeight.w600,
            fontSize: 28,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartScreen()),
              );
            },
            child: const Text(
              'Edit Cart',
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
          ),
        ],
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: getUserDoc(),
        builder: (context, userSnapshot) {
          if (userSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!userSnapshot.hasData || !userSnapshot.data!.exists) {
            return const Center(child: Text('User data not found.'));
          }
          final user = userSnapshot.data!.data()!;
          final fullName = user['fullName'] ?? 'No Name';
          final phone = user['phoneNumber'] ?? 'No Phone';
          final address = user['address'] ?? 'No Address';
          final cardNumber = user['paymentNumber'];

          return StreamBuilder<List<Map<String, dynamic>>>(
            stream: widget.cartFirebase.fetchCartItems(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(
                  child: Text(
                    'Your cart is empty',
                    style: TextStyle(fontSize: 16),
                  ),
                );
              }

              final items = snapshot.data!;
              double total = 0;

              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    const Text(
                      'Delivery Information',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        fontFamily: 'AnticSlab',
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Icon(Icons.person_outline, size: 22),
                        const SizedBox(width: 8),
                        Text(fullName, style: const TextStyle(fontSize: 16)),
                        const Spacer(),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Edit',
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.phone_outlined, size: 22),
                        const SizedBox(width: 8),
                        Text(phone, style: const TextStyle(fontSize: 16)),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.location_on_outlined, size: 22),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            address,
                            style: const TextStyle(fontSize: 16),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    // Payment Method
                    const Text(
                      'Payment Method',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        fontFamily: 'AnticSlab',
                      ),
                    ),
                    const SizedBox(height: 10),
                    _PaymentMethodSelector(
                      cardNumber: cardNumber,
                      selected: selectedPaymentMethod,
                      onChanged: (method) {
                        setState(() {
                          selectedPaymentMethod = method;
                        });
                      },
                    ),
                    const SizedBox(height: 18),
                    // Order Summary
                    const Text(
                      'Order Summary',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        fontFamily: 'AnticSlab',
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 4,
                      ),
                      child: Row(
                        children: const [
                          Expanded(
                            flex: 4,
                            child: Text(
                              'Item',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              'Qty',
                              style: TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Text(
                              'Subtotal',
                              style: TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: items.length,
                      separatorBuilder: (context, index) => const Divider(),
                      itemBuilder: (context, index) {
                        final item = items[index];
                        final name = item['productName'] ?? 'Unnamed';
                        final size = item['size'] ?? 'N/A';
                        final quantity =
                            int.tryParse(item['quantity'].toString()) ?? 0;
                        final price =
                            double.tryParse(item['price'].toString()) ?? 0.0;
                        final subtotal = quantity * price;
                        total += subtotal;

                        return Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: Text(
                                '$name ($size)',
                                style: const TextStyle(fontSize: 15),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                '$quantity',
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 15),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Text(
                                'Rs. ${subtotal.toStringAsFixed(2)}',
                                textAlign: TextAlign.right,
                                style: const TextStyle(fontSize: 15),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'Shipping',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        Text(
                          'Rs. 200.00',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'Discount',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        Text(
                          '- Rs. 0.00',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    const Divider(height: 24, thickness: 1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Rs. ${total.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: CheckoutScreen.pinkColor,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        onPressed: () {
                          if (selectedPaymentMethod == 'cash') {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const OrderPlacedScreen(),
                              ),
                            );
                            // Place order logic here
                          } else {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) =>
                                        const ProcessingPaymentScreen(),
                              ),
                            );
                            // Start payment deduction logic here
                          }
                        },
                        child: const Text(
                          'Proceed',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _PaymentMethodSelector extends StatefulWidget {
  final String? cardNumber;
  final String selected;
  final ValueChanged<String> onChanged;

  const _PaymentMethodSelector({
    required this.cardNumber,
    required this.selected,
    required this.onChanged,
  });

  @override
  State<_PaymentMethodSelector> createState() => _PaymentMethodSelectorState();
}

class _PaymentMethodSelectorState extends State<_PaymentMethodSelector> {
  late bool isCard;
  late bool isCash;

  @override
  void initState() {
    super.initState();
    isCard = widget.selected == 'card';
    isCash = widget.selected == 'cash';
  }

  @override
  void didUpdateWidget(covariant _PaymentMethodSelector oldWidget) {
    super.didUpdateWidget(oldWidget);
    isCard = widget.selected == 'card';
    isCash = widget.selected == 'cash';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Checkbox(
              value: isCard,
              onChanged: (val) {
                setState(() {
                  isCard = true;
                  isCash = false;
                });
                widget.onChanged('card');
              },
            ),
            Text(
              widget.cardNumber != null
                  ? '**** **** **** ${widget.cardNumber.toString().substring(widget.cardNumber.toString().length - 4)}'
                  : 'Card Number',
              style: TextStyle(
                fontSize: 16,
                color: widget.cardNumber != null ? Colors.black : Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            TextButton(
              onPressed: () {},
              child: const Text(
                'Change',
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Checkbox(
              value: isCash,
              onChanged: (val) {
                setState(() {
                  isCard = false;
                  isCash = true;
                });
                widget.onChanged('cash');
              },
            ),
            const Text(
              'Cash on Delivery',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
