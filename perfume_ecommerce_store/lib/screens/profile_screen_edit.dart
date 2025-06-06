import 'package:flutter/material.dart';
import '../firebase/profile_firebase.dart';

class ProfileEditPage extends StatefulWidget {
  final Map<String, dynamic> userData;
  const ProfileEditPage({super.key, required this.userData});

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController locationController;
  late TextEditingController accountNumberController;
  String selectedPaymentMethod = "Jazzcash";
  final List<String> paymentMethods = ["Jazzcash", "Easypaisa"];
  final ProfileService _profileService = ProfileService();

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(
      text: widget.userData['fullName'] ?? "",
    );
    emailController = TextEditingController(
      text: widget.userData['email'] ?? "",
    );
    phoneController = TextEditingController(
      text: widget.userData['phoneNumber'] ?? "",
    );
    locationController = TextEditingController(
      text: widget.userData['address'] ?? "",
    );
    selectedPaymentMethod = widget.userData['paymentMethod'] ?? "Jazzcash";
    accountNumberController = TextEditingController(
      text: widget.userData['paymentNumber'] ?? "",
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    locationController.dispose();
    accountNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
        backgroundColor: const Color(0xFFE4B1AB),
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Personal Info Section
              const Text(
                "Personal Information",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              _buildTextField("Name", nameController),
              _buildTextField("Email", emailController),
              _buildTextField("Mobile", phoneController),
              _buildTextField("Address", locationController),
              const SizedBox(height: 30),

              // Payment Info Section
              const Text(
                "Payment Information",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),

              DropdownButtonFormField<String>(
                value: selectedPaymentMethod,
                decoration: const InputDecoration(
                  labelText: "Payment Method",
                  border: OutlineInputBorder(),
                ),
                items:
                    paymentMethods.map((method) {
                      return DropdownMenuItem(
                        value: method,
                        child: Text(method),
                      );
                    }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedPaymentMethod = value!;
                  });
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: accountNumberController,
                decoration: const InputDecoration(
                  labelText: "Account Number",
                  border: OutlineInputBorder(),
                ),
                validator:
                    (value) =>
                        value!.isEmpty ? "Please enter account number" : null,
              ),

              const SizedBox(height: 30),

              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await _profileService.updateUserData({
                      'fullName': nameController.text.trim(),
                      'email': emailController.text.trim(),
                      'phoneNumber': phoneController.text.trim(),
                      'address': locationController.text.trim(),
                      'paymentMethod': selectedPaymentMethod,
                      'paymentNumber': accountNumberController.text.trim(),
                    });
                    if (mounted) Navigator.pop(context, true);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE4B1AB),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Save",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator: (value) => value!.isEmpty ? "Please enter $label" : null,
      ),
    );
  }
}
