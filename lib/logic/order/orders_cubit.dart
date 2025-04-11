import 'package:bloc/bloc.dart';
import 'package:malabis_app/data/repository/order_repository.dart';
import 'package:malabis_app/logic/order/orders_state.dart';
import 'package:malabis_app/util/gql_queries.dart';

class OrdersCubit extends Cubit<OrdersState> {
  final OrdersRepository repository;

  OrdersCubit(this.repository) : super(OrdersState());

  void getPendingOrders(int userId) async {
    emit(state.copyWith(pendingOrderState: 'searching'));
    try {
      final result = await repository.getPendingOrders(
        GQLQuries.pendingOrdersQuery,
        {'customer_id': userId},
      );
      emit(state.copyWith(
        pendingOrdersResult: result,
        pendingOrderState: 'loaded',
      ));
    } catch (e) {
      emit(state.copyWith(pendingOrderState: 'error'));
    }
  }

  void getDeliveredOrders(int userId) async {
    emit(state.copyWith(deliveredOrderStatus: 'searching'));
    try {
      final result = await repository.getDeliveredOrders(
        GQLQuries.deliveredOrderQuery,
        {'customer_id': userId},
      );
      emit(state.copyWith(
        deliveredOrderResult: result,
        deliveredOrderStatus: 'loaded',
      ));
    } catch (e) {
      emit(state.copyWith(deliveredOrderStatus: 'error'));
    }
  }

  void getCanceledOrders(int userId) async {
    emit(state.copyWith(canceledOrdersStatus: 'searching'));
    try {
      final result = await repository.getCanceledOrders(
        GQLQuries.canceledOrdersQuery,
        {'customer_id': userId},
      );
      emit(state.copyWith(
        canceledOrdersResult: result,
        canceledOrdersStatus: 'loaded',
      ));
    } catch (e) {
      emit(state.copyWith(canceledOrdersStatus: 'error'));
    }
  }

  void trackOrder(int orderId) async {
    emit(state.copyWith(trackOrderStatus: 'searching'));
    try {
      final result = await repository.trackOrder(
        GQLQuries.trackOrderQuery,
        {'id': orderId},
      );
      emit(state.copyWith(
        trackOrderResult: result,
        trackOrderStatus: 'loaded',
      ));
    } catch (e) {
      emit(state.copyWith(trackOrderStatus: 'error'));
    }
  }
}