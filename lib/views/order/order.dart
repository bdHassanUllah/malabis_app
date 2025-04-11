import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:malabis_app/logic/order/orders_cubit.dart';
import 'package:malabis_app/logic/order/orders_state.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
      ),
      body: BlocBuilder<OrdersCubit, OrdersState>(
        builder: (context, state) {
           if (state.pendingOrderState == 'loaded') {
            final orders = state.pendingOrdersResult!.data?['listOrdersFilters']['orders'];
            return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return ListTile(
                  title: Text("Order #${order['id']}"),
                  subtitle: Text("Total: Rs. ${order['total']}"),
                  trailing: Text(order['order_status']['name']),
                );
              },
            );
          } else {
            return const Center(child: Text("Failed to load orders"));
          }
        },
      ),
    );
  }
}