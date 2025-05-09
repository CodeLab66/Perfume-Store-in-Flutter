import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> uploadWomenSectionData() async {
  final List<Map<String, dynamic>> womenSectionData = [
    {
      "title": "Gucci Bloom",
      "subtitle": "50 ml",
      "price": 75.00,
      "imagePath": "assets/images/chanel_chance.jpeg",
    },
    {
      "title": "Dior J'adore",
      "subtitle": "50 ml",
      "price": 95.00,
      "imagePath": "assets/images/dior_sauvage.jpeg",
    },
    {
      "title": "Carolina Herrera",
      "subtitle": "100 ml",
      "price": 80.00,
      "imagePath": "assets/images/chanel_chance.jpeg",
    },
    {
      "title": "Miss Dior",
      "subtitle": "100 ml",
      "price": 89.00,
      "imagePath": "assets/images/dior_sauvage.jpeg",
    },
  ];

  try {
    final collectionRef = FirebaseFirestore.instance.collection(
      'women_section',
    );

    for (final item in womenSectionData) {
      await collectionRef.add(item);
    }
  } catch (e) {
    print('Error uploading women section data: $e');
  }
}
