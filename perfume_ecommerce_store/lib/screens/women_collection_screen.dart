import 'package:flutter/material.dart';
import 'product_screen.dart';
import 'index.dart'; // Import where ProductCard is defined

class WomenCollectionScreen extends StatelessWidget {
  const WomenCollectionScreen({super.key});

  final List<Map<String, String>> products = const [
    {
      'title': 'Gucci Bloom',
      'subtitle': '50 ml',
      'price': '75.00\$',
      'image': 'assets/images/gucci_bloom.jpeg',
    },
    {
      'title': 'Dior J\'adore',
      'subtitle': '50 ml',
      'price': '95.00\$',
      'image': 'assets/images/jadore.jpeg',
    },
    {
      'title': 'Chanel No. 5',
      'subtitle': '50 ml',
      'price': '105.00\$',
      'image': 'assets/images/chanel_no5.jpeg',
    },
    {
      'title': 'YSL Libre',
      'subtitle': '50 ml',
      'price': '89.00\$',
      'image': 'assets/images/ysl_libre.jpeg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Women Collection'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          itemCount: products.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            childAspectRatio: 0.75,
          ),
          itemBuilder: (context, index) {
            final product = products[index];
            return ProductCard(
              title: product['title']!,
              subtitle: product['subtitle']!,
              price: product['price']!,
              imagePath: product['image']!,
            );
          },
        ),
      ),
    );
  }
}
