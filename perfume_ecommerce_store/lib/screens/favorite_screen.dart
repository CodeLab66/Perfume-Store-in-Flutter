import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'index.dart';
import 'cart_screen.dart';
import 'profile_screen.dart';
import 'product_screen.dart';
import '../firebase/product_firebase.dart' as product_firebase;

final FirebaseFirestore _db = FirebaseFirestore.instance;

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<String>>(
      stream: product_firebase.userFavoritesStream(),
      builder: (context, favSnapshot) {
        final favoriteIds = favSnapshot.data ?? [];
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: const Text(
              'Favorites',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Your Favorites',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                const Text(
                  'Perfumes that matches your taste',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child:
                      favoriteIds.isEmpty
                          ? const Center(child: Text('No favorites yet'))
                          : GridView.builder(
                            itemCount: favoriteIds.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 15,
                                  mainAxisSpacing: 20,
                                  childAspectRatio: 0.65,
                                ),
                            itemBuilder: (context, index) {
                              final productName = favoriteIds[index];
                              return StreamBuilder<product_firebase.Product?>(
                                stream: product_firebase.fetchProductByName(
                                  productName,
                                ),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                  if (!snapshot.hasData ||
                                      snapshot.data == null) {
                                    return const SizedBox();
                                  }
                                  final product = snapshot.data!;
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder:
                                              (context) => ProductPageScreen(
                                                title: product.name,
                                              ),
                                        ),
                                      );
                                    },
                                    child: ProductCard(
                                      title: product.name,
                                      subtitle: product.size,
                                      price:
                                          'Rs. ${product.price.toStringAsFixed(2)}',
                                      imagePath: product.image,
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: Colors.grey.shade200)),
            ),
            child: BottomNavigationBar(
              currentIndex: 1, // Favorites tab is selected
              selectedItemColor: const Color(0xFFE4B1AB),
              unselectedItemColor: Colors.grey,
              backgroundColor: Colors.white,
              elevation: 0,
              type: BottomNavigationBarType.fixed,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              onTap: (index) {
                if (index != 1) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) =>
                              index == 0
                                  ? const HomeScreen()
                                  : index == 2
                                  ? const CartScreen()
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
        );
      },
    );
  }
}
