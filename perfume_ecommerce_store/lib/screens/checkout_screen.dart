import 'package:flutter/material.dart';
import 'cart_screen.dart'; // Make sure this points to your actual CartScreen file

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String name = "John Doe";
  String phone = "xxxxxxxxxxx";
  String address = "123 Sunset Blvd, LA";
  String paymentMethod = "Card Number: **** **** **** 1234";

  void _editInfo(String title, String currentValue, Function(String) onSave) {
    final controller = TextEditingController(text: currentValue);

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text("Edit $title"),
            content: TextField(
              controller: controller,
              decoration: InputDecoration(hintText: "Enter $title"),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                  onSave(controller.text);
                  Navigator.pop(context);
                },
                child: const Text("Save"),
              ),
            ],
          ),
    );
  }

  void _changePaymentMethod() {
    showModalBottomSheet(
      context: context,
      builder:
          (_) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.credit_card),
                title: const Text("Credit/Debit Card"),
                onTap: () {
                  setState(
                    () => paymentMethod = "Card Number: **** **** **** 1234",
                  );
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.account_balance_wallet),
                title: const Text("PayPal"),
                onTap: () {
                  setState(() => paymentMethod = "PayPal: johndoe@email.com");
                  Navigator.pop(context);
                },
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
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
            _infoRow(
              Icons.person,
              name,
              trailing: "Edit",
              onTap:
                  () => _editInfo(
                    "Name",
                    name,
                    (val) => setState(() => name = val),
                  ),
            ),
            const SizedBox(height: 10),
            _infoRow(
              Icons.phone,
              phone,
              trailing: "Edit",
              onTap:
                  () => _editInfo(
                    "Phone",
                    phone,
                    (val) => setState(() => phone = val),
                  ),
            ),
            const SizedBox(height: 10),
            _infoRow(
              Icons.location_on,
              address,
              trailing: "Edit",
              onTap:
                  () => _editInfo(
                    "Address",
                    address,
                    (val) => setState(() => address = val),
                  ),
            ),
            const Divider(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Payment Method",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                GestureDetector(
                  onTap: _changePaymentMethod,
                  child: const Text(
                    "Change",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Text(paymentMethod, style: const TextStyle(color: Colors.grey)),
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
            _summaryItem("Myself (50ml)", 1, 70.99),
            const Divider(height: 30),
            _summaryLine("Shipping", 0.00),
            _summaryLine("Discount", 0.00, isDiscount: true),
            const Divider(height: 10),
            _summaryLine("Total", 212.98, isTotal: true),
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

  Widget _infoRow(
    IconData icon,
    String text, {
    String? trailing,
    VoidCallback? onTap,
  }) {
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
          GestureDetector(
            onTap: onTap,
            child: Text(trailing, style: const TextStyle(color: Colors.grey)),
          ),
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
