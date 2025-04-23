import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:malabis_app/logic/authentication/authentication_cubit.dart';
import '../../logic/authentication/authentication_state.dart';

class AccountsScreen extends StatelessWidget {
  const AccountsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              if (state is AuthAuthenticated) {
                final user = state.user;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.grey.shade200,
                          child: const Icon(Icons.arrow_back, color: Colors.black),
                        ),
                        const SizedBox(width: 20),
                        Flexible(
                          child: Text(
                            user.displayName ?? 'User',
                            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                          ),
                        ),
                        const SizedBox(width: 10),
                        CircleAvatar(
                          radius: 35,
                          backgroundColor: Colors.amber.shade100,
                          backgroundImage: user.photoURL != null
                              ? NetworkImage(user.photoURL!)
                              : null,
                          child: user.photoURL == null
                              ? const Icon(Icons.person, color: Colors.amber, size: 30)
                              : null,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text("My Information", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),

                    // User info
                    buildInfoRow("Name", user.displayName ?? 'Not available'),
                    buildInfoRow("Phone no", user.phoneNumber ?? 'Not provided'),
                    buildInfoRow("Email", user.email ?? 'No email'),
                    buildInfoRow("Shipping Address", "N/A"),

                    const SizedBox(height: 20),
                    const Text("My Orders", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          buildOrderRow("Order #1", "Rs. 3,150"),
                          const Divider(),
                          buildOrderRow("Order #2", "Rs. 3,150"),
                        ],
                      ),
                    ),

                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        buildActionButton("Logout", Colors.amber, Colors.white, onTap: () {
                          context.read<AuthCubit>().signOut();
                        }),
                        buildActionButton("Update Info", Colors.white, Colors.amber, border: true),
                      ],
                    ),
                  ],
                );
              } else if (state is AuthLoading) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return const Center(child: Text("Please log in to see your account"));
              }
            },
          ),
        ),
      ),
    );
  }

  Widget buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(flex: 2, child: Text(label, style: const TextStyle(fontWeight: FontWeight.w500))),
          Expanded(flex: 3, child: Text(value)),
        ],
      ),
    );
  }

  Widget buildOrderRow(String title, String price) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(price, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget buildActionButton(String text, Color bgColor, Color textColor,
      {bool border = false, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150,
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(30),
          border: border ? Border.all(color: Colors.amber, width: 2) : null,
        ),
        alignment: Alignment.center,
        child: Text(text, style: TextStyle(color: textColor, fontWeight: FontWeight.w500)),
      ),
    );
  }
}
