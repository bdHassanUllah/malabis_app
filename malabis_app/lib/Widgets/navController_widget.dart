import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../screens/home_screen.dart';   // Import your screens


class NavigationController extends GetxController {
  var selectedIndex = 0.obs;

  void changeTabIndex(int index) {
    selectedIndex.value = index;
  }

  final List<Widget> pages = [
    HomeScreen(),
    //SearchScreen(),
    //CartScreen(),
    //ProfileScreen(),
  ];
}
