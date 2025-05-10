import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product_model.dart';
import 'product_screen.dart';

class MenCollectionScreen extends StatefulWidget {
  const MenCollectionScreen({super.key});

  @override
  State<MenCollectionScreen> createState() => _MenCollectionScreenState();
}

class _MenCollectionScreenState extends State<MenCollectionScreen> {
  List<Product> perfumes = [];

  @override
  void initState() {
    super.initState();
    fetchPerfumes();
  }

  Future<void> fetchPerfumes() async {
    try {
      final querySnapshot =
          await FirebaseFirestore.instance.collection('men_section').get();
      setState(() {
        perfumes =
            querySnapshot.docs
                .map((doc) => Product.fromFirestore(doc.data()))
                .toList();
      });
    } catch (e) {
      print('Error fetching perfumes: $e');
    }
  }

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
      body:
          perfumes.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                padding: const EdgeInsets.all(20.0),
                child: GridView.builder(
                  itemCount: perfumes.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    childAspectRatio: 0.7,
                  ),
                  itemBuilder: (context, index) {
                    final product = perfumes[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (_) => ProductPageScreen(
                                  title: product.title,
                                  subtitle: product.subtitle,
                                  price: product.price.toStringAsFixed(2),
                                  imagePath: product.imagePath,
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
                            Image.network(
                              product.imagePath,
                              height: 100,
                              fit: BoxFit.contain,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              product.title,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              product.subtitle,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              '${product.price.toStringAsFixed(2)}',
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
    );
  }
}
