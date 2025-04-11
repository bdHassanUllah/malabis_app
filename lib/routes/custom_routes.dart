import 'package:flutter/material.dart';
import 'package:malabis_app/routes/routes_name.dart';
import 'package:malabis_app/views/authentication/signup/welcome_screen.dart';
import 'package:malabis_app/views/cart/cart.dart';
import 'package:malabis_app/views/home/home_page.dart';
import 'package:malabis_app/views/splash_screen.dart';

class CustomRoutes {
  static Route<dynamic> allRoutes(RouteSettings setting) {
    switch (setting.name) {
      case "/": // Add default root route
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case welcomescreen:
        return MaterialPageRoute(builder: (_) =>  WelcomeScreen());
      case homePage:
        return MaterialPageRoute(builder: (_) => HomePage());
      case cartscreen:
        return MaterialPageRoute(builder: (_) => CartPage(cart: [],));
      default:
        throw Exception('Route not found: ${setting.name}');
    }
  }
}
