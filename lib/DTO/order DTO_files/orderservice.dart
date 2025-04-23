
import 'package:dio/dio.dart';
import 'package:malabis_app/DTO/order%20DTO_files/order_request_dto.dart' as dto;
import 'package:malabis_app/data/model/order_model.dart';

class OrderService {
  final Dio dio;

  OrderService(this.dio);

  Future<OrderModel> createOrder(dto.CreateOrderRequestDto orderDto) async {
    try {
      final response = await dio.post(
        '/wp-json/wc/v3/orders',
        data: orderDto.toJson(),
      );
      
      // Convert response to OrderModel
      return OrderModel.fromJson(response.data);
    } on DioException catch (e) {
      print("Order creation failed: ${e.response?.data}");
      throw Exception("Failed to place order: ${e.response?.data['message'] ?? e.message}");
    }
  }
}