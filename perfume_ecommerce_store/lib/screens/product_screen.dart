import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../firebase/product_firebase.dart' as product_firebase;
import '../firebase/cart_firebase.dart';

List<String> favorites = [];
String? currentUserId;

Future<void> loadFavorites() async {
  final prefs = await SharedPreferences.getInstance();
  if (currentUserId != null) {
    favorites = prefs.getStringList('favorites_$currentUserId') ?? [];
  }
}

Future<void> saveFavorites() async {
  final prefs = await SharedPreferences.getInstance();
  if (currentUserId != null) {
    await prefs.setStringList('favorites_$currentUserId', favorites);
  }
}

class ProductPageScreen extends StatefulWidget {
  final String title;

  const ProductPageScreen({super.key, required this.title});

  @override
  State<ProductPageScreen> createState() => _ProductPageScreenState();
}

class _ProductPageScreenState extends State<ProductPageScreen> {
  bool isFavorited = false;
  static final List<String> cart = [];
  String selectedSize = '50 ml';

  void toggleFavorite(String productId) async {
    setState(() {
      isFavorited = !isFavorited;
    });
    if (isFavorited) {
      await product_firebase.addFavorite(productId);
    } else {
      await product_firebase.removeFavorite(productId);
    }
  }

  void addToCart(product_firebase.Product product) async {
    final cartItem = {
      'productName': product.name,
      'price': product.price,
      'quantity': 1,
      'size': product.size,
      'image': product.image, // Add image if you want to show it in cart
    };
    await CartFirebase().addOrUpdateCartItem(cartItem);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Added to cart!')));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<product_firebase.Product>(
      stream: product_firebase.fetchProductByName(widget.title),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasError || !snapshot.hasData) {
          return Scaffold(body: Center(child: Text('Product not found')));
        }
        final product = snapshot.data!;
        return StreamBuilder<List<String>>(
          stream: product_firebase.userFavoritesStream(),
          builder: (context, favSnapshot) {
            final favs = favSnapshot.data ?? [];
            isFavorited = favs.contains(product.name);
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                centerTitle: true,
                title: Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Image.asset('assets/images/roselle.png', width: 40),
                ),
              ),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Image.network(
                        product.image,
                        height: 220,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                product.name,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'AnticSlab',
                                ),
                              ),
                              IconButton(
                                icon: Icon(
                                  isFavorited
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: isFavorited ? Colors.red : Colors.grey,
                                ),
                                onPressed: () => toggleFavorite(product.name),
                              ),
                            ],
                          ),
                          Text(
                            product.size,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            product.description,
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Rs. ${product.price.toStringAsFixed(0)}',
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Center(
                            child: ElevatedButton(
                              onPressed: () => addToCart(product),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFE8A0A0),
                              ),
                              child: const Text(
                                'Add to Cart',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
