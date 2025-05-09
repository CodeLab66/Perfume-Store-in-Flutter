import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> uploadMenSectionData() async {
  final List<Map<String, dynamic>> menSectionData = [
    {
      "title": "Bleu de Chanel",
      "subtitle": "50 ml",
      "price": 85.00,
      "imagePath": "assets/images/ysl_myself.jpeg",
    },
    {
      "title": "Dior Sauvage",
      "subtitle": "100 ml",
      "price": 99.00,
      "imagePath": "assets/images/versace_bright_crystal.jpeg",
    },
    {
      "title": "Versace Eros",
      "subtitle": "50 ml",
      "price": 78.00,
      "imagePath": "assets/images/ysl_myself.jpeg",
    },
    {
      "title": "Armani Code",
      "subtitle": "100 ml",
      "price": 89.00,
      "imagePath": "assets/images/versace_bright_crystal.jpeg",
    },
  ];

  try {
    final collectionRef = FirebaseFirestore.instance.collection('men_section');

    for (final item in menSectionData) {
      await collectionRef.add(item);
    }
  } catch (e) {
    print('Error uploading men section data: $e');
  }
}
