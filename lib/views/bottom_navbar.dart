import 'package:flutter/material.dart';
import 'package:malabis_app/util/config/destination.dart';
import 'package:malabis_app/util/constant.dart';
import 'package:malabis_app/views/cart/cart.dart';
import 'package:malabis_app/views/home/home_page.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _index = 0;

  List<Widget> allDestinations = [
    const HomePage(),
    const CartPage(cart: [],),
    //const FavouritePage(),
    //const OrdersPage(),
    //const SettingsPage()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: IndexedStack(
          index:_index,
          children: allDestinations,
        ),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20)),
            boxShadow: [
              BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
            ],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
            child: BottomNavigationBar(
              currentIndex: _index,
              onTap: (int index) {
                setState(() {
                  _index = index;
                });
              },
              selectedItemColor: kUniversalColor,
              type: BottomNavigationBarType.fixed,
              items:
                  Destinations.allDestinations.map((Destinations destinations) {
                return BottomNavigationBarItem(
                  icon: destinations.icon,
                  label: destinations.title,
                );
              }).toList(),
            ),
          ),
        ));
  }
}
