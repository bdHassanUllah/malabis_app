import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:malabis_app/logic/cart/cart_cubit.dart';

class ProductDetailPage extends StatefulWidget {
  final Map<String, dynamic> product;

  const ProductDetailPage({super.key, required this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final price = double.tryParse(product['price'].toString()) ?? 0;
    final reward = int.tryParse(product['reward'].toString()) ?? 0;
    final productId = int.tryParse(product['id'].toString()) ?? 0;

    final cartCubit = context.watch<CartCubit>();
    final isInCart = cartCubit.state.cartList.any((item) => item.product_id == productId);

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.black12,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                const CircleAvatar(
                  backgroundColor: Colors.black12,
                  child: Icon(Icons.favorite_border),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Center(
              child: Image.network(
                product['image_url'] ?? '',
                height: 250,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    "lib/assets/images/dummy_product.png",
                    height: 250,
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Text(
              product['name'] ?? '',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Rs. ${product['price']}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text('• ${product['uom'] ?? ''}'),
            const SizedBox(height: 16),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          setState(() {
                            if (quantity > 1) quantity--;
                          });
                        },
                      ),
                      Text('$quantity', style: const TextStyle(fontSize: 18)),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            quantity++;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (isInCart) {
                        cartCubit.deleteItem(index: cartCubit.state.cartList.indexWhere((item) => item.product_id == productId));
                        Fluttertoast.showToast(
                          msg: "${product['name']} removed from cart",
                          gravity: ToastGravity.BOTTOM,
                        );
                      } else {
                        cartCubit.addToCart(
                          productID: productId,
                          productName: product['name'],
                          price: price,
                          quantity: quantity,
                          image: product['image_url'],
                          //reward: reward,
                          //uom: product['uom'],
                        );
                        Fluttertoast.showToast(
                          msg: "${product['name']} added to cart",
                          gravity: ToastGravity.BOTTOM,
                        );
                      }
                      setState(() {}); // Refresh button label
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.white,
                      side: const BorderSide(color: Colors.black),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text(isInCart ? 'Remove from Cart' : 'Add to Cart'),
                  ),
                )
              ],
            ),
            const SizedBox(height: 24),
            buildSection(
              title: 'Description',
              content: 'Agenda - Jaffer Brothers\n\n'
                  'Scratch & Corrosion Free Glass Cleaner, which may also be used on all hard surfaces to have a neat and clean look',
            ),
            buildExpansion('Use'),
            buildExpansion('Direction for Use'),
            buildExpansion('Warnings'),
            buildExpansion('Safety Datasheet'),
            buildExpansion('PSCIR Report'),
          ],
        ),
      ),
    );
  }

  Widget buildSection({required String title, required String content}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Text(content),
        const Divider(height: 24),
      ],
    );
  }

  Widget buildExpansion(String title) {
    return ExpansionTile(
      tilePadding: EdgeInsets.zero,
      title: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      children: const [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Text('Details coming soon...'),
        )
      ],
    );
  }
}
