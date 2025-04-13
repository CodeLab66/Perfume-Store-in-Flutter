import 'package:flutter/material.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final products = [
      {
        'title': 'Dior Sauvage',
        'subtitle': '50 ml',
        'price': '89.99\$',
        'imagePath': 'assets/images/dior_sauvage.jpeg',
      },
      {
        'title': 'Chanel Chance',
        'subtitle': '50 ml',
        'price': '119.99\$',
        'imagePath': 'assets/images/chanel_chance.jpeg',
      },
      {
        'title': 'Dior Sauvage',
        'subtitle': '50 ml',
        'price': '89.99\$',
        'imagePath': 'assets/images/dior_sauvage.jpeg',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
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
                  childAspectRatio: 0.65, // Wider and taller cards
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
    );
  }
}

class FavoriteProductCard extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF1F1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Top Row: Like icon aligned to right
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [Icon(Icons.favorite, color: Colors.red, size: 18)],
          ),
          const SizedBox(height: 7),

          // Image with border radius
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(imagePath, height: 100, fit: BoxFit.contain),
          ),
          const SizedBox(height: 10),

          // Text Content
          Text(
            title,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            subtitle,
            style: const TextStyle(fontSize: 15, color: Colors.grey),
          ),
          const SizedBox(height: 5),

          // Price
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
    );
  }
}
