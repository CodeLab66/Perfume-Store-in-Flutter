import 'package:flutter/material.dart';

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({super.key});

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  final _formKey = GlobalKey<FormState>();

  // Personal Info Controllers
  final nameController = TextEditingController(text: "Arooj Qudsia");
  final emailController = TextEditingController(text: "qudsia@gmail.com");
  final phoneController = TextEditingController(text: "+1 234 567 890");
  final locationController = TextEditingController(
    text: "Street 123, City, Country",
  );

  // Payment Info
  String selectedPaymentMethod = "Jazzcash";
  final accountNumberController = TextEditingController(text: "03244551504");
  final List<String> paymentMethods = ["Jazzcash", "Easypaisa"];

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
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.pop(context); // Go back to previous screen
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
