//State Implementation dynamic real code 
/*import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:malabis_app/logic/authentication/authentication_cubit.dart';
import 'package:malabis_app/logic/home/home_cubit.dart';
import 'package:malabis_app/logic/home/home_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    final cubit = BlocProvider.of<HomeCubit>(context, listen: false);
    final authCubit = BlocProvider.of<AuthenticationCubit>(context, listen: false);
    print(authCubit.getuserID);
    cubit.getCategoryList();
    //cubit.getBannerImages();
  }

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                // Search Bar + Cart Icon
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Search for Anything",
                            prefixIcon: Icon(Icons.search),
                            filled: true,
                            fillColor: Colors.grey[200],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      CircleAvatar(
                        backgroundColor: Colors.grey[200],
                        child: Icon(Icons.shopping_cart, color: Colors.black),
                      ),
                    ],
                  ),
                ),

                // Banner Section
                // Banner Section
Padding(
  padding: const EdgeInsets.symmetric(horizontal: 15),
  child: Container(
    height: 150,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
    ),
    clipBehavior: Clip.hardEdge,
    child: Image.network(
      'https://example.com/dummy_product.png', // Replace with dynamic URL if needed
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Image.asset(
          'assets/images/dummy_product.png',
          fit: BoxFit.cover,
        );
      },
    ),
  ),
),


                SizedBox(height: 15),

                // Latest Products Heading
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Latest Products",
                      style: GoogleFonts.montserrat(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 10),

                // Product Grid View
                state.productState == 'searching'
                    ? Center(child: CircularProgressIndicator())
                    : // Product Grid View
state.productState == 'searching'
    ? Center(child: CircularProgressIndicator())
    : GridView.builder(
        itemCount: state.productResult!.data?['listProductsFilter']['products'].length,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(horizontal: 15),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.65,
        ),
        itemBuilder: (ctx, i) {
          var product = state.productResult!.data?['listProductsFilter']['products'][i];
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                    child: Image.network(
                      product['image_url'] ?? '',
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'assets/images/dummy_product.png',
                          width: double.infinity,
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    product['name'],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.montserrat(fontWeight: FontWeight.w500),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Rs ${product['price']}",
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.yellow.shade700,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.shopping_cart, color: Colors.white, size: 18),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8),
              ],
            ),
          );
        },
      ),

              ],
            ),
          ),
        );
      },
    );
  }
}*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:malabis_app/logic/cart/cart_cubit.dart';
import 'package:malabis_app/logic/home/home_cubit.dart';
import 'package:malabis_app/logic/home/home_state.dart';
import 'package:malabis_app/views/cart/cart.dart';
import 'package:malabis_app/views/sub_views/productfull_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getProductsList(0), // Dummy user ID for now
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Search for Anything",
                          prefixIcon: Icon(Icons.search),
                          filled: true,
                          fillColor: Colors.grey[200],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CartPage(cart: []),
                          ),
                        );
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.grey[200],
                        child: Icon(
                          Icons.shopping_cart,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Container(
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: Image.network(
                    'https://example.com/dummy_product.png',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        'lib/assets/images/dummy_product.png',
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
              ),

              SizedBox(height: 15),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Latest Products",
                    style: GoogleFonts.montserrat(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 10),

              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  if (state.productState == 'searching') {
                    return Center(child: CircularProgressIndicator());
                  } else if (state.productState == 'error') {
                    return Center(child: Text("Error loading products"));
                  } else if (state.productState == 'loaded') {
                    return GridView.builder(
                      itemCount: state.products?.length,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 0.65,
                      ),
                      itemBuilder: (ctx, i) {
                        final product = state.products![i];

                        return BlocBuilder<CartCubit, CartState>(
                          builder: (context, cartState) {
                            final isInCart = cartState.cartList.any(
                                (item) => item.product_id == product.id);

                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => ProductDetailPage(product: {
                                      'id': product.id.toString(),
                                      'name': product.name,
                                      'image_url': product.Image,
                                      'price': product.price.toString(),
                                      //'reward': product.discount.toString(),
                                      //'uom': 'pcs',
                                    }),
                                  ),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: Colors.grey.shade300),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.vertical(top: Radius.circular(12)),
                                        child: Image.network(
                                          product.Image,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                          errorBuilder: (context, error, stackTrace) {
                                            return Image.asset(
                                              'lib/assets/images/dummy_product.png',
                                              width: double.infinity,
                                              fit: BoxFit.cover,
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        product.name,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.montserrat(fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.symmetric(horizontal: 8),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Rs ${product.price}",
                                            style: GoogleFonts.montserrat(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.green,
                                            ),
                                          ),
                                          IconButton(
                                            icon: Icon(
                                              isInCart
                                                  ? Icons.remove_shopping_cart
                                                  : Icons.add_shopping_cart,
                                              color: isInCart
                                                  ? Colors.red
                                                  : Colors.yellow.shade700,
                                            ),
                                            onPressed: () {
                                              final cartCubit =
                                                  context.read<CartCubit>();
                                              if (isInCart) {
                                                cartCubit.deleteItem(
                                                  index: cartState.cartList.indexWhere(
                                                      (item) =>
                                                          item.product_id ==
                                                          product.id),
                                                );
                                                Fluttertoast.showToast(
                                                    msg:
                                                        "${product.name} removed from cart");
                                              } else {
                                                cartCubit.addToCart(
                                                  productID: product.id,
                                                  productName: product.name,
                                                  price: product.price,
                                                  quantity: 1,
                                                  image: product.Image,
                                                  //reward: product.discount ?? 0,
                                                  //uom: 'pcs',
                                                );
                                                Fluttertoast.showToast(
                                                    msg:
                                                        "${product.name} added to cart");
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  } else {
                    return SizedBox.shrink();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}