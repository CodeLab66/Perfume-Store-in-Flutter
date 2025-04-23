import 'package:flutter/material.dart';
import 'cart_screen.dart';
//import 'delivery_screen.dart'; // create this page
import 'profile_screen_edit.dart'; // create this page

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  bool useCashOnDelivery = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CartScreen()),
              );
            },
            child: const Text(
              "Edit Cart",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Delivery Information",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ProfileEditPage(),
                      ),
                      //MaterialPageRoute(builder: (_) => const DeliveryScreen()),
                    );
                  },
                  child: const Text(
                    "Edit",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            _infoRow(Icons.person, "John Doe"),
            const SizedBox(height: 5),
            _infoRow(Icons.phone, "xxxxxxxxxxx"),
            const SizedBox(height: 5),
            _infoRow(Icons.location_on, "123 Sunset blvd , LA"),
            const Divider(height: 30),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Payment Method",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ProfileEditPage(),
                      ),
                    );
                  },
                  child: const Text(
                    "Change",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Checkbox(value: false, onChanged: (_) {}),
                const Text("Card Number"),
              ],
            ),
            Row(
              children: [
                Checkbox(
                  value: useCashOnDelivery,
                  onChanged: (val) {
                    setState(() => useCashOnDelivery = val ?? false);
                  },
                ),
                const Text("Cash on Delivery"),
              ],
            ),

            const Divider(height: 30),
            const Text(
              "Order Summary",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 10),
            _summaryHeader(),
            _summaryItem("Myself (50ml)", 2, 141.99),
            _summaryItem("Myself (50ml)", 2, 141.99),
            _summaryItem("Myself (50ml)", 2, 141.99),
            const Divider(height: 30),
            _summaryLine("Shipping", 0.00),
            _summaryLine("Discount", 0.00, isDiscount: true),
            const Divider(height: 10),
            _summaryLine("Total", 28.97, isTotal: true),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD58580),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Order Confirmed!")),
                );
              },
              child: const Text(
                "Go to Checkout",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String value) {
    return Row(
      children: [Icon(icon, size: 20), const SizedBox(width: 8), Text(value)],
    );
  }

  Widget _summaryHeader() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Item", style: TextStyle(fontWeight: FontWeight.bold)),
        Text("Qty", style: TextStyle(fontWeight: FontWeight.bold)),
        Text("Subtotal", style: TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _summaryItem(String item, int qty, double price) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(item),
        Text(qty.toString()),
        Text("\$${price.toStringAsFixed(2)}"),
      ],
    );
  }

  Widget _summaryLine(
    String label,
    double amount, {
    bool isDiscount = false,
    bool isTotal = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          "${isDiscount ? "-" : ""}\$${amount.toStringAsFixed(2)}",
          style: TextStyle(
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            fontSize: isTotal ? 16 : 14,
          ),
        ),
      ],
    );
  }
}
