import 'package:flutter/material.dart';
import 'index.dart';
import 'cart_screen.dart';
import 'profile_screen.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final products = [
      {
        'title': 'Dior Sauvage',
        'subtitle': '50 ml',
        'price': 'Rs. 52,320',
        'imagePath': 'assets/images/dior_sauvage.jpeg',
      },
      {
        'title': 'Chanel Chance',
        'subtitle': '50 ml',
        'price': 'Rs. 65,000',
        'imagePath': 'assets/images/chanel_chance.jpeg',
      },
      {
        'title': 'YSL Myself',
        'subtitle': '100 ml',
        'price': 'Rs. 50,000',
        'imagePath': 'assets/images/ysl_myself.jpeg',
      },
    ];

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
                  builder: (context) =>
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
      padding: const EdgeInsets.all(5),
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
                  size: 20,
                ),
                onPressed: () {
                  setState(() {
                    isFavorite = !isFavorite;
                  });
                },
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
          const SizedBox(height: 2),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              widget.imagePath,
              height: 110,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 5),

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
