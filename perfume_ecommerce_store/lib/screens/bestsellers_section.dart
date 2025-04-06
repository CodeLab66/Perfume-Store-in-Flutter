import 'package:flutter/material.dart';
import 'product_screen.dart';

class BestSellersScreen extends StatelessWidget {
  const BestSellersScreen({super.key});

  static final List<Map<String, String>> bestSellers = [
    {
      'title': 'Chanel Coco Mademoiselle',
      'subtitle': '50 ml',
      'price': '99.00\$',
      'imagePath': 'assets/images/chanel_chance.jpeg',
    },
    {
      'title': 'Dior Sauvage',
      'subtitle': '100 ml',
      'price': '120.00\$',
      'imagePath': 'assets/images/dior_sauvage.jpeg',
    },
    {
      'title': 'YSL Black Opium',
      'subtitle': '50 ml',
      'price': '110.00\$',
      'imagePath': 'assets/images/chanel_chance.jpeg',
    },
    {
      'title': 'Bleu de Chanel',
      'subtitle': '100 ml',
      'price': '130.00\$',
      'imagePath': 'assets/images/dior_sauvage.jpeg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Image.asset('assets/images/roselle.png', height: 50),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () {
              // Future: Navigate to search page
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Best Sellers',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                fontFamily: 'AnticSlab',
              ),
            ),
            const Text(
              'Customer favorites and all-time classics',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 20),

            // Grid of Best Sellers
            Expanded(
              child: GridView.builder(
                itemCount: bestSellers.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  childAspectRatio: 0.7,
                ),
                itemBuilder: (context, index) {
                  final product = bestSellers[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (_) => ProductPageScreen(
                                title: product['title']!,
                                subtitle: product['subtitle']!,
                                price: product['price']!,
                                imagePath: product['imagePath']!,
                              ),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF1F1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            product['imagePath']!,
                            height: 100,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            product['title']!,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            product['subtitle']!,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            product['price']!,
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
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
