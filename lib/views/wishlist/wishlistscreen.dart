import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:malabis_app/data/model/product_model.dart.dart';
import 'package:malabis_app/logic/whishlist/whishlistcubit.dart';
import 'package:malabis_app/views/home/home_page.dart'; // If ProductCard is here

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wishlist'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever),
            onPressed: () {
              context.read<WishlistCubit>().clearWishlist();
            },
          ),
        ],
      ),
      body: BlocBuilder<WishlistCubit, List<int>>(
        builder: (context, wishlist) {
          if (wishlist.isEmpty) {
            return const Center(
              child: Text('No products in the wishlist'),
            );
          }

          // Limit the number of products shown at once for testing
          final limitedWishlist = wishlist.take(20).toList(); // Show only the first 20

          return ListView.builder(
            itemCount: limitedWishlist.length,
            itemBuilder: (context, index) {
              final productId = limitedWishlist[index];

              return SizedBox( // ✅ Ensures layout safety
                height: 160,
                child: FutureBuilder<Product>(
                  future: fetchProductById(productId),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError || snapshot.data == null) {
                      return const Center(child: Text('Error loading product'));
                    }

                    return ProductCard(product: snapshot.data!);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<Product> fetchProductById(int productId) async {
    // Replace this with actual product fetching logic
    return Product(
      id: productId,
      name: "Sample Product",
      price: '100',
      images: [],
      stockStatus: 'In Stock',
      description: 'Sample description',
      categories: [],
    );
  }
}
