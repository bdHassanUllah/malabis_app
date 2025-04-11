import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:malabis_app/data/providers/orders_provider.dart';

class OrdersRepository {
  final ordersProvider = OrdersProvider();

  Future<QueryResult> getPendingOrders(String query, variable) async {
    return await ordersProvider.getPendingOrders(query, variable);
  }

  Future<QueryResult> getDeliveredOrders(String query, variable) async {
    return await ordersProvider.getDeliveredOrders(query, variable);
  }

  Future<QueryResult> getCanceledOrders(String query, variable) async {
    return await ordersProvider.getCanceledOrders(query, variable);
  }

  Future<QueryResult> trackOrder(String query, variable) async {
    return await ordersProvider.trackOrder(query, variable);
  }
}