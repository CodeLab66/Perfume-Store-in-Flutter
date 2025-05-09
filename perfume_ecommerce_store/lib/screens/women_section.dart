import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product_model.dart';

class WomenCollectionScreen extends StatefulWidget {
  const WomenCollectionScreen({super.key});

  @override
  State<WomenCollectionScreen> createState() => _WomenCollectionScreenState();
}

class _WomenCollectionScreenState extends State<WomenCollectionScreen> {
  List<Product> perfumes = [];

  @override
  void initState() {
    super.initState();
    fetchPerfumes();
  }

  Future<void> fetchPerfumes() async {
    try {
      final querySnapshot =
          await FirebaseFirestore.instance.collection('women_section').get();
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
      appBar: AppBar(title: const Text('Women Collection')),
      body:
          perfumes.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                itemCount: perfumes.length,
                itemBuilder: (context, index) {
                  final perfume = perfumes[index];
                  return ListTile(
                    leading: Image.network(perfume.imagePath),
                    title: Text(perfume.title),
                    subtitle: Text(perfume.subtitle),
                    trailing: Text('${perfume.price.toStringAsFixed(2)}'),
                  );
                },
              ),
    );
  }
}
