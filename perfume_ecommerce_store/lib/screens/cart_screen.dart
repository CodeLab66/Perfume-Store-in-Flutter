import 'package:flutter/material.dart';
import 'index.dart';
import 'favorite_screen.dart';
import 'profile_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final Color pinkColor = const Color(0xFFE4B1AB);
  final List<Map<String, dynamic>> cartItems = [
    {
      'title': 'Myself',
      'subtitle': '50 ml',
      'price': 70.99,
      'quantity': 2,
      'imagePath': 'assets/images/ysl_myself.jpeg',
    },
    {
      'title': 'Chanel Chance',
      'subtitle': '50 ml',
      'price': 119.99,
      'quantity': 2,
      'imagePath': 'assets/images/chanel_chance.jpeg',
    },
    {
      'title': 'Sauvage',
      'subtitle': '50 ml',
      'price': 89.99,
      'quantity': 2,
      'imagePath': 'assets/images/dior_sauvage.jpeg',
    },
  ];

  void updateQuantity(int index, bool increase) {
    setState(() {
      if (increase) {
        cartItems[index]['quantity']++;
      } else if (cartItems[index]['quantity'] > 1) {
        cartItems[index]['quantity']--;
      }
    });
  }

  void clearCart() {
    setState(() {
      cartItems.clear();
    });
  }

  double get totalAmount {
    return cartItems.fold(
      0.0,
      (sum, item) =>
          sum + (item['price'] as double) * (item['quantity'] as int),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey.shade200)),
        ),
        child: BottomNavigationBar(
          currentIndex: 2, // Cart is selected
          selectedItemColor: pinkColor,
          unselectedItemColor: Colors.grey,
          backgroundColor: Colors.white,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          onTap: (index) {
            if (index != 2) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder:
                      (context) =>
                          index == 0
                              ? const HomeScreen()
                              : index == 1
                              ? const FavoriteScreen()
                              : const ProfileViewPage(),
                ),
              );
            }
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined, size: 28),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border, size: 28),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart, size: 28),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline, size: 28),
              label: '',
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          'Cart',
          style: TextStyle(color: Colors.black, fontSize: 28),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 16, top: 8),
            child: Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: clearCart,
                child: const Text(
                  'Clear Cart',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          item['imagePath'],
                          width: 70,
                          height: 70,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['title'],
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              item['subtitle'],
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '\$${item['price'].toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFE4E1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(
                                minWidth: 20,
                                minHeight: 20,
                              ),
                              onPressed: () => updateQuantity(index, false),
                              icon: const Icon(
                                Icons.remove,
                                size: 16,
                                color: Colors.black54,
                              ),
                            ),
                            Text(
                              '${item['quantity']}',
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            IconButton(
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(
                                minWidth: 20,
                                minHeight: 20,
                              ),
                              onPressed: () => updateQuantity(index, true),
                              icon: const Icon(
                                Icons.add,
                                size: 16,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${cartItems.length} Items',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                    Text(
                      '\$${totalAmount.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '\$${totalAmount.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.65,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE4B1AB),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(25),
                          topRight: Radius.circular(25),
                        ),
                      ),
                    ),
                    child: const Text(
                      'Go to Checkout',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
