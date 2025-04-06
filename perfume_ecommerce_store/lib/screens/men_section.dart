import 'package:flutter/material.dart';
import 'product_screen.dart';

class MenCollectionScreen extends StatefulWidget {
  const MenCollectionScreen({super.key});

  @override
  State<MenCollectionScreen> createState() => _MenCollectionScreenState();
}

class _MenCollectionScreenState extends State<MenCollectionScreen> {
  final List<Map<String, String>> allPerfumes = [
    {
      'title': 'Bleu de Chanel',
      'subtitle': '50 ml',
      'price': '85.00\$',
      'imagePath': 'assets/images/ysl_myself.jpeg',
    },
    {
      'title': 'Dior Sauvage',
      'subtitle': '100 ml',
      'price': '99.00\$',
      'imagePath': 'assets/images/versace_bright_crystal.jpeg',
    },
    {
      'title': 'Versace Eros',
      'subtitle': '50 ml',
      'price': '78.00\$',
      'imagePath': 'assets/images/ysl_myself.jpeg',
    },
    {
      'title': 'Armani Code',
      'subtitle': '100 ml',
      'price': '89.00\$',
      'imagePath': 'assets/images/versace_bright_crystal.jpeg',
    },
  ];

  List<Map<String, String>> filteredPerfumes = [];
  String selectedSize = 'All';
  String selectedSort = 'Name A-Z';

  @override
  void initState() {
    super.initState();
    filteredPerfumes = List.from(allPerfumes);
    applySort();
  }

  void applyFilter() {
    setState(() {
      if (selectedSize == 'All') {
        filteredPerfumes = List.from(allPerfumes);
      } else {
        filteredPerfumes =
            allPerfumes
                .where((item) => item['subtitle'] == selectedSize)
                .toList();
      }
      applySort();
    });
  }

  void applySort() {
    filteredPerfumes.sort((a, b) {
      switch (selectedSort) {
        case 'Name A-Z':
          return a['title']!.compareTo(b['title']!);
        case 'Name Z-A':
          return b['title']!.compareTo(a['title']!);
        case 'Price Low to High':
          return extractPrice(a['price']!).compareTo(extractPrice(b['price']!));
        case 'Price High to Low':
          return extractPrice(b['price']!).compareTo(extractPrice(a['price']!));
        default:
          return 0;
      }
    });
  }

  double extractPrice(String price) {
    return double.tryParse(price.replaceAll('\$', '')) ?? 0.0;
  }

  void showFilterDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Filter by Size'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children:
                  ['All', '50 ml', '100 ml']
                      .map(
                        (size) => RadioListTile<String>(
                          title: Text(size),
                          value: size,
                          groupValue: selectedSize,
                          onChanged: (value) {
                            setState(() {
                              selectedSize = value!;
                              Navigator.pop(context);
                              applyFilter();
                            });
                          },
                        ),
                      )
                      .toList(),
            ),
          ),
    );
  }

  void showSortDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Sort by'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children:
                  [
                    'Name A-Z',
                    'Name Z-A',
                    'Price Low to High',
                    'Price High to Low',
                  ].map((sortOption) {
                    return RadioListTile<String>(
                      title: Text(sortOption),
                      value: sortOption,
                      groupValue: selectedSort,
                      onChanged: (value) {
                        setState(() {
                          selectedSort = value!;
                          Navigator.pop(context);
                          applySort();
                        });
                      },
                    );
                  }).toList(),
            ),
          ),
    );
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Men Collection',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                fontFamily: 'AnticSlab',
              ),
            ),
            const Text(
              'Wear Your unseen Aura',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 20),

            // Filter & Sort Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Filter Button
                OutlinedButton.icon(
                  onPressed: showFilterDialog,
                  icon: const Icon(Icons.filter_list),
                  label: Text('Filter ($selectedSize)'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.black,
                    side: const BorderSide(color: Colors.grey),
                  ),
                ),

                // Sort Button (as dialog)
                OutlinedButton.icon(
                  onPressed: showSortDialog,
                  icon: const Icon(Icons.sort),
                  label: Text('Sort ($selectedSort)'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.black,
                    side: const BorderSide(color: Colors.grey),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Grid of Products
            Expanded(
              child: GridView.builder(
                itemCount: filteredPerfumes.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  childAspectRatio: 0.7,
                ),
                itemBuilder: (context, index) {
                  final product = filteredPerfumes[index];
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
                        color: const Color(0xFFD6ECF5),
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
