// main_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:malabis_app/util/config/destination.dart';
import 'package:malabis_app/views/account/accounts.dart';
import 'package:malabis_app/views/cart/cart.dart';
import 'package:malabis_app/views/home/home_page.dart';
import 'package:malabis_app/views/order/order_history.dart';
import 'package:malabis_app/views/wishlist/wishlistscreen.dart';
import 'package:malabis_app/logic/navigation/navigation_cubit.dart';

class MainScaffold extends StatelessWidget {
  final List<Widget> screens = [
    HomePage(),
    CartScreen(),
    WishlistScreen(),
    OrderHistoryScreen(customerId: 1),
    AccountsScreen(),
  ];

   MainScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, NavigationState>(
      builder: (context, state) {
        return Scaffold(
          body: IndexedStack(
            index: state.selectedIndex,
            children: screens,
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: state.selectedIndex,
            onTap: (index) =>
                context.read<NavigationCubit>().updateIndex(index),
            items: Destinations.allDestinations.map((destination) {
              return BottomNavigationBarItem(
                icon: destination.icon,
                label: destination.title,
              );
            }).toList(),
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.grey,
            backgroundColor: Colors.white,
          ),
        );
      },
    );
  }
}
