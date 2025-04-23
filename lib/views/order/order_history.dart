import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:malabis_app/logic/order/orders_cubit.dart';
import 'package:malabis_app/logic/order/orders_state.dart';

class OrderHistoryScreen extends StatefulWidget {
  final int customerId;

  const OrderHistoryScreen({super.key, required this.customerId});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  @override
  void initState() {
    super.initState();
    debugPrint("Fetching orders for customerId: ${widget.customerId}");
    context.read<OrderCubit>().fetchOrders(widget.customerId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Order History')),
      body: BlocBuilder<OrderCubit, OrderState>(
        builder: (context, state) {
          if (state is OrderLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is OrderSuccess) {
            final orders = state.orders; // ✅ Replace props with orders

            if (orders.isEmpty) {
              return const Center(child: Text('No orders found.'));
            }

            return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    title: Text('Order #${order.id}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Status: ${order.status}'),
                        Text('Total: \$${order.total}'),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (state is OrderFailure) {
            return Center(child: Text(state.error));
          } else {
            return const Center(child: Text('Fetch your orders.'));
          }
        },
      ),
    );
  }
}
