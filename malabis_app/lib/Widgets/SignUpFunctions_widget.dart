import 'package:flutter/material.dart';

class SignupFunctions {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  // Function to build TextFormFields
  Widget buildTextField({
    required String label,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
      ),
      keyboardType: keyboardType,
      validator: validator ?? (value) => value!.isEmpty ? "$label is required" : null,
    );
  }

  // Function to build Password Fields
  Widget buildPasswordField({
    required String label,
    required TextEditingController controller,
    required Function(void Function()) setStateCallback, // Pass setState from UI
    bool validateConfirmPassword = false,
  }) {
    return StatefulBuilder(
      builder: (context, setState) {
        return TextFormField(
          controller: controller,
          obscureText: label == "Password" ? obscurePassword : obscureConfirmPassword,
          decoration: InputDecoration(
            labelText: label,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
            suffixIcon: IconButton(
              icon: Icon(
                (label == "Password" ? obscurePassword : obscureConfirmPassword)
                    ? Icons.visibility_off
                    : Icons.visibility,
              ),
              onPressed: () {
                setState(() {
                  setStateCallback(() {
                    if (label == "Password") {
                      obscurePassword = !obscurePassword;
                    } else {
                      obscureConfirmPassword = !obscureConfirmPassword;
                    }
                  });
                });
              },
            ),
          ),
          validator: validateConfirmPassword
              ? (value) {
                  if (value!.isEmpty) return "Confirm Password is required";
                  if (value != passwordController.text) return "Passwords do not match";
                  return null;
                }
              : (value) => value!.isEmpty ? "$label is required" : null,
        );
      },
    );
  }

  // Email Validation
  String? validateEmail(String? value) {
    if (value!.isEmpty) return "Email is required";
    final emailRegex = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
    if (!emailRegex.hasMatch(value)) return "Enter a valid email";
    return null;
  }

  // Phone Number Validation
  String? validatePhoneNumber(String? value) {
    if (value!.isEmpty) return "Phone number is required";
    final phoneRegex = RegExp(r"^\d{10,15}$");
    if (!phoneRegex.hasMatch(value)) return "Enter a valid phone number";
    return null;
  }

  // Form Submission
  void submitForm(GlobalKey<FormState> formKey, BuildContext context) {
    if (formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Account Created Successfully!")));
    }
  }
}
