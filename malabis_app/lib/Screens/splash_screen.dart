import 'package:flutter/material.dart';
import 'package:malabis_app/Screens/welcome_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Navigate to Home Screen after 2 seconds
    Future.delayed(Duration(seconds: 2), () {
      //Calling the HomeScreen class
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => WelcomeScreen()),
      );
    });

    return Scaffold(
      backgroundColor: Colors.white, //Set the backgraound color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'lib/assets/images/MalabisLogo.png',
                  width:
                      MediaQuery.of(context).size.width *
                      0.8, // Responsive width
                ),
              ],
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ), // Responsive padding
            ),
          ],
        ),
      ),
    );
  }
}
