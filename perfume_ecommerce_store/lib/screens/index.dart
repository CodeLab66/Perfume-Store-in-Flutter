// lib/screens/index.dart

import 'package:flutter/material.dart';
import '../firebase/index_firebase.dart';
import 'product_screen.dart';
import 'women_section.dart';
import 'men_section.dart';
import 'bestsellers_section.dart';
import 'favorite_screen.dart';
import 'profile_screen.dart';
import 'cart_screen.dart';

const Color primaryColor = Color(0xFFFFF1F1);

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final firestoreService = FirestoreService();

    Widget buildSection(
      String title,
      String subtitle,
      Widget navigateTo,
      Stream<List<Product>> stream,
    ) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(
            title: title,
            subtitle: subtitle,
            navigateTo: navigateTo,
          ),
          const SizedBox(height: 20),
          StreamBuilder<List<Product>>(
            stream: stream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
              final products = snapshot.data ?? [];
              if (products.isEmpty) {
                return const Center(child: Text('No products available'));
              }
              // limit to max 3 products
              final displayed = products.take(3).toList();

              // ← wrap in horizontal scroll
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:
                      displayed.map((p) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: ProductCard(
                            title: p.name,
                            subtitle: '50 ml',
                            price: 'Rs. ${p.price}',
                            imagePath: p.image,
                          ),
                        );
                      }).toList(),
                ),
              );
            },
          ),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.white70,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset('assets/images/roselle.png', height: 55),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSection(
              'Best Sellers',
              'The Best Perfume Ever',
              const BestSellersScreen(),
              firestoreService.fetchProductsByCategory('Best Seller'),
            ),
            const SizedBox(height: 30),
            buildSection(
              'Men',
              'Make your fragrance your signature',
              const MenCollectionScreen(),
              firestoreService.fetchProductsByCategory('Men'),
            ),
            const SizedBox(height: 30),
            buildSection(
              'Women',
              'Elegance in every drop',
              const WomenCollectionScreen(),
              firestoreService.fetchProductsByCategory('Women'),
            ),
          ],
        ),
      ),

      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey.shade200)),
        ),
        child: BottomNavigationBar(
          currentIndex: 0,
          selectedItemColor: const Color(0xFFE4B1AB),
          unselectedItemColor: Colors.grey,
          backgroundColor: Colors.white,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          onTap: (i) {
            if (i != 0) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder:
                      (_) =>
                          i == 1
                              ? const FavoriteScreen()
                              : i == 2
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
  }
}

/// Reusable section header
class SectionHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget navigateTo;

  const SectionHeader({
    super.key,
    required this.title,
    required this.subtitle,
    required this.navigateTo,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'AnticSlab',
              ),
            ),
            Text(
              subtitle,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
        TextButton(
          onPressed:
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => navigateTo),
              ),
          child: const Text(
            'See All >',
            style: TextStyle(
              color: Color(0xFFE8A0A0),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

/// Card widget for a product
class ProductCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String price;
  final String imagePath;

  const ProductCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:
          () => Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (_) => ProductPageScreen(
                    title: title,
                    subtitle: subtitle,
                    price: price,
                    imagePath: imagePath,
                  ),
            ),
          ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.4,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Image.network(imagePath, height: 100, fit: BoxFit.contain),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Text(
              subtitle,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 10),
            Text(
              price,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
