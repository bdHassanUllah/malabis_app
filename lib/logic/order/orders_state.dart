import 'package:graphql_flutter/graphql_flutter.dart';

class OrdersState {
  final QueryResult? pendingOrdersResult;
  final String? pendingOrderState;
  final QueryResult? deliveredOrderResult;
  final String? deliveredOrderStatus;
  final QueryResult? canceledOrdersResult;
  final String? canceledOrdersStatus;
  final QueryResult? trackOrderResult;
  final String? trackOrderStatus;

  OrdersState({
    this.pendingOrdersResult,
    this.pendingOrderState = 'searching',
    this.deliveredOrderResult,
    this.deliveredOrderStatus = 'searching',
    this.canceledOrdersResult,
    this.canceledOrdersStatus = 'searching',
    this.trackOrderResult,
    this.trackOrderStatus = 'searching',
  });

  OrdersState copyWith({
    QueryResult? pendingOrdersResult,
    String? pendingOrderState,
    QueryResult? deliveredOrderResult,
    String? deliveredOrderStatus,
    QueryResult? canceledOrdersResult,
    String? canceledOrdersStatus,
    QueryResult? trackOrderResult,
    String? trackOrderStatus,
  }) {
    return OrdersState(
      pendingOrdersResult: pendingOrdersResult ?? this.pendingOrdersResult,
      pendingOrderState: pendingOrderState ?? this.pendingOrderState,
      deliveredOrderResult: deliveredOrderResult ?? this.deliveredOrderResult,
      deliveredOrderStatus: deliveredOrderStatus ?? this.deliveredOrderStatus,
      canceledOrdersResult: canceledOrdersResult ?? this.canceledOrdersResult,
      canceledOrdersStatus: canceledOrdersStatus ?? this.canceledOrdersStatus,
      trackOrderResult: trackOrderResult ?? this.trackOrderResult,
      trackOrderStatus: trackOrderStatus ?? this.trackOrderStatus,
    );
  }
}