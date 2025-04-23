import 'package:malabis_app/data/model/order_model.dart';
import 'package:malabis_app/data/providers/orders_provider.dart';

class OrderRepository {
  final OrderProvider provider;

  OrderRepository(this.provider);

  Future<OrderModel> placeOrder(Map<String, dynamic> orderData) async {
  try {
    final response = await provider.placeOrder(orderData);

    // Debug this to confirm its actual structure
    final data = response.data;

    if (data is Map<String, dynamic>) {
      return OrderModel.fromJson(data);
    } else {
      throw Exception("Invalid response format: ${data.runtimeType}");
    }
  } catch (e) {
    throw Exception('Failed to place order: $e');
  }
}


  Future<List<OrderModel>> getOrdersByCustomerId(int customerId) async {
    try {
      final response = await provider.getOrdersByCustomerId(customerId);
      final List<dynamic> data = response;
      return data.map((json) => OrderModel.fromJson(json as Map<String, dynamic>)).toList();
    } catch (e) {
      throw Exception('Failed to fetch orders: $e');
    }
  }
}
