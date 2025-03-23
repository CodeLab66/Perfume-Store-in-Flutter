import 'package:flutter/material.dart';
//import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductPageScreen extends StatelessWidget {
  final String title;
  final String subtitle;
  final String price;
  final String imagePath;

  const ProductPageScreen({
    super.key,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('assets/images/roselle.png', width: 40),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(imagePath, height: 250, fit: BoxFit.contain),
              ),
              const SizedBox(height: 20),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'AnticSlab',
                ),
              ),
              const SizedBox(height: 8),
              Row(
                // children: [
                //   RatingBarIndicator(
                //     rating: 5.0,
                //     itemBuilder: (context, index) => const Icon(Icons.star, color: Colors.amber),
                //     itemCount: 5,
                //     itemSize: 20.0,
                //   ),
                //   const SizedBox(width: 5),
                //   const Text('5.0', style: TextStyle(fontSize: 16)),
                // ],
              ),
              const SizedBox(height: 10),
              const Text(
                'Chance Eau de Parfum by Chanel is a Chypre Floral fragrance for men. Launched in 2005. Top note is Pink Pepper; middle notes are Jasmine and Iris; base notes are Patchouli, Musk, and Vanilla.',
                style: TextStyle(fontSize: 15, color: Colors.grey),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Price',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Available sizes',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    price,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      ChoiceChip(
                        label: const Text('50 ml'),
                        selected: true,
                        onSelected: (bool selected) {},
                      ),
                      const SizedBox(width: 10),
                      ChoiceChip(
                        label: const Text('100 ml'),
                        selected: false,
                        onSelected: (bool selected) {},
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE8A0A0),
                  ),
                  child: const Text('Add to Cart'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
