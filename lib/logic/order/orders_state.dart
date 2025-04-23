import 'package:equatable/equatable.dart';
import 'package:malabis_app/data/model/order_model.dart';

abstract class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object?> get props => [];
}

class OrderInitial extends OrderState {}

class OrderLoading extends OrderState {}

class OrderSuccess extends OrderState {
  final List<OrderModel> orders;

  const OrderSuccess(this.orders);

  @override
  List<Object?> get props => [orders];
}

class OrderPlaced extends OrderState {
  final OrderModel order;

  const OrderPlaced(this.order);

  @override
  List<Object?> get props => [order];
}

class OrderFailure extends OrderState {
  final String error;

  const OrderFailure(this.error);

  @override
  List<Object?> get props => [error];
}
