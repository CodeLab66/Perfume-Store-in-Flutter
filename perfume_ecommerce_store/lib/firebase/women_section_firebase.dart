import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> uploadWomenSectionData() async {
  final List<Map<String, dynamic>> womenSectionData = [
    {
      "name": "Gucci Bloom",
      "description":
          "Gucci Bloom is a rich, white floral fragrance that transports you to a garden full of blooming flowers. Notes of jasmine, tuberose, and Rangoon creeper create a fresh and natural scent.",
      "price": 75.00,
      "image": "assets/images/chanel_chance.jpeg",
      "category": ["Women"],
    },
    {
      "name": "Dior J'adore",
      "description":
          "Dior J'adore is a luminous fragrance with a blend of ylang-ylang, Damascus rose, and jasmine. It embodies elegance, femininity, and luxury.",
      "price": 95.00,
      "image": "assets/images/dior_sauvage.jpeg",
      "category": ["Women"],
    },
    {
      "name": "Carolina Herrera",
      "description":
          "Carolina Herrera is a modern, vibrant fragrance with notes of tuberose, jasmine, and orange blossom. Perfect for the confident and stylish woman.",
      "price": 80.00,
      "image": "assets/images/chanel_chance.jpeg",
      "category": ["Women"],
    },
    {
      "name": "Miss Dior",
      "description":
          "Miss Dior is a romantic and fresh fragrance with notes of Italian mandarin, rose, and patchouli. A timeless scent for every occasion.",
      "price": 89.00,
      "image": "assets/images/dior_sauvage.jpeg",
      "category": ["Women"],
    },
  ];

  try {
    final collectionRef = FirebaseFirestore.instance.collection('products');
    for (final item in womenSectionData) {
      await collectionRef.add(item);
    }
  } catch (e) {
    print('Error uploading women section data: $e');
  }
}
