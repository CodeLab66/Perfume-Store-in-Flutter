import 'package:flutter/material.dart';

class ProductPageScreen extends StatefulWidget {
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
  State<ProductPageScreen> createState() => _ProductPageScreenState();
}

class _ProductPageScreenState extends State<ProductPageScreen> {
  bool isFavorited = false;
  static final List<String> favorites = []; // This is the favorites list

  String selectedSize = '50 ml'; // Default selected size

  void toggleFavorite() {
    setState(() {
      isFavorited = !isFavorited;
      if (isFavorited) {
        favorites.add(widget.title); // Add perfume to favorites
      } else {
        favorites.remove(widget.title); // Remove if un-favorited
      }
    });
  }

  void selectSize(String size) {
    setState(() {
      selectedSize = size;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // Back to previous page
          },
        ),
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.only(top: 4.0),
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
                child: Image.asset(
                  widget.imagePath,
                  height: 250,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'AnticSlab',
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      isFavorited ? Icons.favorite : Icons.favorite_border,
                      color: isFavorited ? Color(0xFFE8A0A0) : Colors.black,
                    ),
                    onPressed: toggleFavorite,
                  ),
                ],
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
                    widget.price,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      ChoiceChip(
                        label: const Text(
                          '50 ml',
                          style: TextStyle(color: Colors.black),
                        ),
                        selected: selectedSize == '50 ml',
                        selectedColor: const Color(0xFFE8A0A0),
                        backgroundColor: const Color(0xFFF4D0D0),
                        onSelected: (bool selected) {
                          if (selected) selectSize('50 ml');
                        },
                      ),
                      const SizedBox(width: 10),
                      ChoiceChip(
                        label: const Text(
                          '100 ml',
                          style: TextStyle(color: Colors.black),
                        ),
                        selected: selectedSize == '100 ml',
                        selectedColor: const Color(0xFFE8A0A0),
                        backgroundColor: const Color(0xFFF4D0D0),
                        onSelected: (bool selected) {
                          if (selected) selectSize('100 ml');
                        },
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
                  child: const Text(
                    'Add to Cart',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
