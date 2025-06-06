import 'package:flutter/material.dart';
import 'profile_screen_edit.dart';
import 'index.dart';
import 'favorite_screen.dart';
import 'cart_screen.dart';
import 'login_screen.dart';
import '../firebase/profile_firebase.dart';

const Color pinkColor = Color(0xFFE4B1AB);

class ProfileViewPage extends StatefulWidget {
  const ProfileViewPage({super.key});

  @override
  State<ProfileViewPage> createState() => _ProfileViewPageState();
}

class _ProfileViewPageState extends State<ProfileViewPage> {
  final ProfileService _profileService = ProfileService();
  Map<String, dynamic>? _userData;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final userData = await _profileService.fetchUserData();
    setState(() {
      _userData = userData;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey.shade200)),
        ),
        child: BottomNavigationBar(
          currentIndex: 3,
          selectedItemColor: pinkColor,
          unselectedItemColor: Colors.grey,
          backgroundColor: Colors.white,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          onTap: (index) {
            if (index != 3) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder:
                      (context) =>
                          index == 0
                              ? const HomeScreen()
                              : index == 1
                              ? const FavoriteScreen()
                              : const CartScreen(),
                ),
              );
            }
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined, size: 28),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border_outlined, size: 28),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart, size: 28),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline, size: 28),
              label: '',
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFFE4B1AB),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
            ),
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 30),
            child: Column(
              children: const [
                SizedBox(height: 20),
                Text(
                  "Profile",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                CircleAvatar(
                  radius: 45,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 50, color: Colors.grey),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  _infoCard(
                    title: "Personal Information",
                    children: [
                      InfoRow("Name", _userData?["fullName"] ?? ""),
                      InfoRow("Email account", _userData?["email"] ?? ""),
                      InfoRow(
                        "Mobile number",
                        _userData?["phoneNumber"] ?? "Add number",
                      ),
                      InfoRow("Location", _userData?["address"] ?? ""),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _paymentCard(context),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: pinkColor,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 50,
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Log out",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoCard({required String title, required List<Widget> children}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: pinkColor,
            ),
          ),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }

  Widget _paymentCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Payment Information",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: pinkColor,
            ),
          ),
          const SizedBox(height: 12),
          InfoRow("Payment Method", _userData?["paymentMethod"] ?? ""),
          InfoRow("Account Number", _userData?["paymentNumber"] ?? ""),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () async {
                final updated = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => ProfileEditPage(userData: _userData ?? {}),
                  ),
                );
                if (updated == true) {
                  _loadData();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: pinkColor,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 10,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                "Edit",
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final String title;
  final String value;

  const InfoRow(this.title, this.value, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 14, color: Colors.black87),
          ),
          Text(value, style: const TextStyle(fontSize: 14, color: Colors.grey)),
        ],
      ),
    );
  }
}
