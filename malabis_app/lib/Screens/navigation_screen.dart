import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:malabis_app/Widgets/navController_Widget.dart';

class BottomNavBarScreen extends StatelessWidget {
  final NavigationController navController = Get.put(NavigationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => IndexedStack(
            index: navController.selectedIndex.value,
            children: navController.pages,
          )),

      bottomNavigationBar: Obx(() => BottomNavigationBar(
            currentIndex: navController.selectedIndex.value,
            onTap: navController.changeTabIndex,
            backgroundColor: Colors.black,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.grey,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
              BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Cart"),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
            ],
          )),
    );
  }
}
