import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> uploadMenSectionData() async {
  final List<Map<String, dynamic>> menSectionData = [
    {
      "name": "Bleu de Chanel",
      "description":
          "A sophisticated blend of citrus and woods, Bleu de Chanel is a timeless fragrance for the modern man. Notes of grapefruit, dry cedar, and sandalwood create a fresh yet deep scent.",
      "size": "50 ml",
      "price": 85.00,
      "image": "assets/images/ysl_myself.jpeg",
      "category": ["Men"],
    },
    {
      "name": "Dior Sauvage",
      "description":
          "Inspired by wide-open spaces, Dior Sauvage is a bold and fresh fragrance with notes of Calabrian bergamot, Sichuan pepper, and Ambroxan. Perfect for those who seek adventure.",
      "size": "100 ml",
      "price": 99.00,
      "image": "assets/images/versace_bright_crystal.jpeg",
      "category": ["Men"],
    },
    {
      "name": "Versace Eros",
      "description":
          "Versace Eros is a fragrance for a strong, passionate man. It features mint leaves, Italian lemon zest, and green apple, balanced with tonka bean and vanilla.",
      "size": "50 ml",
      "price": 78.00,
      "image": "assets/images/ysl_myself.jpeg",
      "category": ["Men"],
    },
    {
      "name": "Armani Code",
      "description":
          "Armani Code is an elegant and seductive fragrance with notes of lemon, olive flower, and guaiac wood. A classic scent for evening wear.",
      "size": "100 ml",
      "price": 89.00,
      "image": "assets/images/versace_bright_crystal.jpeg",
      "category": ["Men"],
    },
  ];

  try {
    final collectionRef = FirebaseFirestore.instance.collection('products');
    for (final item in menSectionData) {
      await collectionRef.add(item);
    }
  } catch (e) {
    print('Error uploading men section data: $e');
  }
}
