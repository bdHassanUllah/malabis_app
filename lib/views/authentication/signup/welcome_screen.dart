import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:malabis_app/functions/custom_button_function.dart';
import 'package:malabis_app/functions/socialMedai_button_function.dart';
import 'package:malabis_app/logic/authentication/authentication_cubit.dart';
import 'package:malabis_app/logic/authentication/authentication_state.dart';
import 'package:malabis_app/views/splash_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state.error != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error!)),
          );
        }
        if (state.loggedIn) {
          // Navigate to home screen when logged in
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => SplashScreen()),
          );
        }
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Welcome!",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Log in or Sign up to continue",
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
                const SizedBox(height: 30),

                // Login Button
                Center(
                  child: CustomButtonWidget(
                    text: "Login",
                    color: Colors.amber.shade700,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SplashScreen()),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 15),

                // Sign Up Button
                Center(
                  child: CustomButtonWidget(
                    text: "Sign Up",
                    textColor: Colors.amber.shade700,
                    borderColor: Colors.amber.shade700,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SplashScreen()),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),

                // OR Divider
                Row(
                  children: const [
                    Expanded(child: Divider(color: Colors.black26)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text("or", style: TextStyle(color: Colors.black54)),
                    ),
                    Expanded(child: Divider(color: Colors.black26)),
                  ],
                ),
                const SizedBox(height: 20),

                // Social Login Buttons
                SocialLoginButton(
                  //FontAwesomeIcons.apple,
                  iconColor: Colors.black,
                  text: "Continue With iCloud", 
                  icon: FontAwesomeIcons.apple,
                ),
                const SizedBox(height: 10),
                BlocBuilder<AuthenticationCubit, AuthenticationState>(
                  builder: (context, state) {
                  return 
                    SocialLoginButton(
                      //FontAwesomeIcons.google,
                      iconColor: Color(0xFF4285F4), // Fixed the color code
                      text: "Continue With Google",
                      icon: FontAwesomeIcons.google,
                      onPressed: state.isLoading
                          ? null
                          : () => context.read<AuthenticationCubit>().signInWithGoogle(),
                      isLoading: state.isLoading,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}