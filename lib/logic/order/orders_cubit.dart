import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:malabis_app/DTO/order%20DTO_files/order_request_dto.dart';
import 'package:malabis_app/data/repository/order_repository.dart';
import 'package:malabis_app/logic/order/orders_state.dart';

class OrderCubit extends Cubit<OrderState> {
  final OrderRepository repository;

  OrderCubit(this.repository) : super(OrderInitial());

  Future<void> fetchOrders(int customerId) async {
    emit(OrderLoading());
    try {
      final orders = await repository.getOrdersByCustomerId(customerId);
      emit(OrderSuccess(orders));
    } catch (e) {
      emit(OrderFailure('Failed to fetch orders: $e'));
    }
  }

  Future<void> placeOrder(CreateOrderRequestDto orderData,) async {
    emit(OrderLoading());
    try {
      final order = await repository.placeOrder(orderData.toJson());
      emit(OrderPlaced(order));
    } catch (e) {
      emit(OrderFailure('Failed to place order: $e'));
    }
  }
}
