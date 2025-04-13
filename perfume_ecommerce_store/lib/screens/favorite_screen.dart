import 'package:flutter/material.dart';
import 'cart_screen.dart';
import 'index.dart' hide CartScreen;

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final products = [
      {
        'title': 'Dior Sauvage',
        'subtitle': '50 ml',
        'price': 'Rs. 52,350',
        'imagePath': 'assets/images/dior_sauvage.jpeg',
      },
      {
        'title': 'Chanel Chance',
        'subtitle': '50 ml',
        'price': 'Rs. 60,999',
        'imagePath': 'assets/images/chanel_chance.jpeg',
      },
      {
        'title': 'Dior J\'adore',
        'subtitle': '100 ml',
        'price': 'Rs. 65,000',
        'imagePath': 'assets/images/dior_sauvage.jpeg',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: null,
        centerTitle: true,
        title: const Text(
          'Favorites',
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
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
              child: GridView.builder(
                itemCount: products.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 20,
                  childAspectRatio: 0.65,
                ),
                itemBuilder: (context, index) {
                  final product = products[index];
                  return FavoriteProductCard(
                    title: product['title']!,
                    subtitle: product['subtitle']!,
                    price: product['price']!,
                    imagePath: product['imagePath']!,
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color(0xFFE8A0A0),
        unselectedItemColor: Colors.grey,
        currentIndex: 1,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          } else if (index == 1) {
            // Do nothing as we are already on the Favorites screen
          } else if (index == 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const CartScreen()),
            );
          } else if (index == 3) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const ProfileScreen()),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
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

class FavoriteProductCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final String price;
  final String imagePath;

  const FavoriteProductCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.imagePath,
  });

  @override
  State<FavoriteProductCard> createState() => _FavoriteProductCardState();
}

class _FavoriteProductCardState extends State<FavoriteProductCard> {
  bool isFavorite = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF1F1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: Colors.red,
                  size: 18,
                ),
                onPressed: () {
                  setState(() {
                    isFavorite = !isFavorite;
                  });
                  // TODO: Add logic to remove from favorites list
                },
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
          const SizedBox(height: 0),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              widget.imagePath,
              height: 110,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 10),

          Text(
            widget.title,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            widget.subtitle,
            style: const TextStyle(fontSize: 15, color: Colors.grey),
          ),
          const SizedBox(height: 5),

          Text(
            widget.price,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
