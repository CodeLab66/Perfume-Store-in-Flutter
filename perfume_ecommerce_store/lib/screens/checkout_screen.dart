import 'package:flutter/material.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              "Edit Cart",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            const Text(
              "Delivery Information",
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10),
            _infoRow(Icons.person, "John Doe", trailing: "Edit"),
            const SizedBox(height: 10),
            _infoRow(Icons.phone, "xxxxxxxxxxx"),
            const SizedBox(height: 10),
            _infoRow(Icons.location_on, "123 Sunset blvd , LA"),
            const Divider(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Payment Method",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text("Change", style: TextStyle(color: Colors.grey)),
              ],
            ),
            const SizedBox(height: 5),
            const Text("Card Number", style: TextStyle(color: Colors.grey)),
            const Divider(height: 30),
            const Text(
              "Order Summary",
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
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
                // Final confirmation or navigation
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

  Widget _infoRow(IconData icon, String text, {String? trailing}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon, size: 20),
            const SizedBox(width: 8),
            Text(text),
          ],
        ),
        if (trailing != null)
          Text(trailing, style: const TextStyle(color: Colors.grey)),
      ],
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

  Widget _summaryItem(String name, int qty, double price) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(name),
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
