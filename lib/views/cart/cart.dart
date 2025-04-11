import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:malabis_app/logic/cart/cart_cubit.dart';
import 'package:malabis_app/views/order/order.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key, required List<Map<String, String>> cart});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  @override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.white,
    body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.arrow_back, color: Colors.black),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    height: 42,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.search, color: Colors.grey),
                        const SizedBox(width: 8),
                        Text(
                          "Search for Anything",
                          style: GoogleFonts.montserrat(color: Colors.grey),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text("My Cart", style: GoogleFonts.montserrat(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: BlocBuilder<CartCubit, CartState>(
                builder: (context, state) {
                  if (state.cartList.isEmpty) {
                    return const Center(child: Text("Cart is Empty"));
                  }

                  return ListView.builder(
                    itemCount: state.cartList.length,
                    itemBuilder: (context, i) {
                      final item = state.cartList[i];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Row(
                          children: [
                            const Icon(Icons.check_circle, color: Colors.orange),
                            const SizedBox(width: 12),
                            Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: DecorationImage(
                                  image: NetworkImage(state.imageList[i]),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item.name,
                                      style: GoogleFonts.montserrat(
                                          fontSize: 16, fontWeight: FontWeight.w600)),
                                  const SizedBox(height: 4),
                                  Text("Rs. ${item.price}",
                                      style: GoogleFonts.montserrat(fontSize: 14)),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove_circle_outline),
                                  onPressed: () => context.read<CartCubit>().decreaseQuantity(index: i),
                                ),
                                Text(
                                  item.quantity.toString(),
                                  style: GoogleFonts.montserrat(fontWeight: FontWeight.w500),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.add_circle_outline),
                                  onPressed: () => context.read<CartCubit>().increaseQuantity(index: i),
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
            MaterialButton(
              minWidth: double.infinity,
              height: 50,
              color: Colors.amber[700],
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OrdersScreen()),
                );
              },
              child: Text(
                "Checkout",
                style: GoogleFonts.montserrat(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
}