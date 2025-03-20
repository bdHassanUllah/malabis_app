import 'package:flutter/material.dart';
import 'package:malabis_app/Widgets/SignUpFunctions_widget.dart';
import 'package:malabis_app/Widgets/button_widgets.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final SignupFunctions _signupFunctions = SignupFunctions();
  bool _isChecked = false; // Checkbox state

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Set Up Your Profile Screen")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Align text to start
              children: [
                // Introductory Text
                const Text(
                  "Create an account so you can manage your donation even faster",
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
                const SizedBox(height: 20),
        
                // Form Fields
                _signupFunctions.buildTextField(
                  label: "Email",
                  keyboardType: TextInputType.emailAddress,
                  validator: _signupFunctions.validateEmail,
                ),
                const SizedBox(height: 16),
        
                _signupFunctions.buildTextField(
                  label: "Phone Number",
                  keyboardType: TextInputType.phone,
                  validator: _signupFunctions.validatePhoneNumber,
                ),
                const SizedBox(height: 16),
        
                _signupFunctions.buildPasswordField(
                  label: "Password",
                  controller: _signupFunctions.passwordController,
                  setStateCallback: setState,
                ),
                const SizedBox(height: 16),
        
                _signupFunctions.buildPasswordField(
                  label: "Confirm Password",
                  controller: _signupFunctions.confirmPasswordController,
                  validateConfirmPassword: true,
                  setStateCallback: setState,
                ),
                const SizedBox(height: 20),
        
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: const Text("By signing in, you agree to our Privacy Policy, which explains how we collect, use, and protect your data."),
                ),
        
                // Checkbox for Privacy Policy Agreement
                Row(
                  children: [
                    Checkbox(
                      value: _isChecked,
                      onChanged: (value) {
                        setState(() {
                          _isChecked = value!;
                        });
                      },
                    ),
                    const Text(
                      "I agree to the Privacy Policy",
                      style: TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
        
                // Signup Button
                CustomButtonWidget(
                  text: "Create an account",
                  color: Colors.amber.shade700,
                  onPressed: () => _signupFunctions.submitForm(_formKey, context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
