import 'package:flutter/material.dart';
import 'package:malabis_app/Screens/home_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            // Logo
            Image.asset(
              'lib/assets/images/MalabisLogo.png', // Ensure this path is correct
              height: 120,
            ),
            const SizedBox(height: 30),
            // Login Text
            const Text(
              "Login to Your Account",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // Email Input Field
            TextField(
              decoration: InputDecoration(
                hintText: "Your Email Address",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),
              ),
            ),
            const SizedBox(height: 15),
            // Password Input Field
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                hintText: "Password",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),
                suffixIcon: const Icon(Icons.visibility_off),
              ),
            ),
            const SizedBox(height: 30),
            // Login Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber.shade700,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  // Handle login logic here
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                },
                child: const Text(
                  "Login",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
