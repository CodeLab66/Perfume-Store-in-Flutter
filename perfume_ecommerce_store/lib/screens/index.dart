import 'package:flutter/material.dart';
import 'product_screen.dart';
import 'women_section.dart';
import 'men_section.dart';
import 'bestsellers_section.dart';
import 'favorite_screen.dart';
import 'profile_screen.dart';
import 'cart_screen.dart';

const Color primaryColor = Color(0xFFFFF1F1); // Card Color

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: const Color.fromARGB(169, 243, 160, 160),
        automaticallyImplyLeading: false,
        leading: null,
        centerTitle: true,
        title: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset('assets/images/roselle.png', height: 55),
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(
              title: 'Best Sellers',
              subtitle: 'The Best Perfume Ever',
              navigateTo: BestSellersScreen(),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                ProductCard(
                  title: 'Dior Sauvage',
                  subtitle: '50 ml',
                  price: 'Rs. 52,350',
                  imagePath: 'assets/images/dior_sauvage.jpeg',
                ),
                ProductCard(
                  title: 'Chanel Chance',
                  subtitle: '50 ml',
                  price: 'Rs. 60,999',
                  imagePath: 'assets/images/chanel_chance.jpeg',
                ),
              ],
            ),
            const SizedBox(height: 30),
            const SectionHeader(
              title: 'Men',
              subtitle: 'Make your fragrance your signature',
              navigateTo: MenCollectionScreen(),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                ProductCard(
                  title: 'Versace Crystal',
                  subtitle: '50 ml',
                  price: 'Rs. 45,000',
                  imagePath: 'assets/images/versace_bright_crystal.jpeg',
                ),
                ProductCard(
                  title: 'YSL Myself',
                  subtitle: '50 ml',
                  price: 'Rs. 50,000',
                  imagePath: 'assets/images/ysl_myself.jpeg',
                ),
              ],
            ),
            const SizedBox(height: 30),
            const SectionHeader(
              title: 'Women',
              subtitle: 'Elegance in every drop',
              navigateTo: WomenCollectionScreen(),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                ProductCard(
                  title: 'Gucci Bloom',
                  subtitle: '50 ml',
                  price: 'Rs. 55,000',
                  imagePath: 'assets/images/chanel_chance.jpeg',
                ),
                ProductCard(
                  title: 'Dior J\'adore',
                  subtitle: '50 ml',
                  price: 'Rs. 65,000',
                  imagePath: 'assets/images/chanel_chance.jpeg',
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color(0xFFE8A0A0),
        unselectedItemColor: Colors.grey,
        currentIndex: 0,
        onTap: (index) {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const FavoriteScreen()),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CartScreen()),
            );
          } else if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfileViewPage()),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

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
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => navigateTo),
            );
          },
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
      onTap: () {
        // Navigate to ProductPageScreen and pass product details
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => ProductPageScreen(
                  title: title,
                  subtitle: subtitle,
                  price: price,
                  imagePath: imagePath,
                ),
          ),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.4,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color(0xFFFFF1F1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(imagePath, height: 100, fit: BoxFit.contain),
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
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search')),
      body: const Center(child: Text('Search Screen')),
    );
  }
}

// class FavoritesScreen extends StatelessWidget {
//   const FavoritesScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Favorites')),
//       body: const Center(child: Text('Favorites Screen')),
//     );
//   }
// }

// class CartScreen extends StatelessWidget {
//   const CartScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Cart')),
//       body: const Center(child: Text('Cart Screen')),
//     );
//   }
// }

// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Profile')),
//       body: const Center(child: Text('Profile Screen')),
//     );
//   }
// }
