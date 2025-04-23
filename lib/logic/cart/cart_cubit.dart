// cart_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:malabis_app/data/model/cart_model.dart';
import 'package:malabis_app/data/model/product_model.dart.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartState());

  bool isInCart(int productId) {
  return state.cartItems.any((item) => item.id == productId);
}

  void addToCart(Product product) {
    final updatedCart = List<CartModel>.from(state.cartItems)..add(CartModel.fromProduct(product));
    emit(CartState(cartItems: updatedCart));
  }

  void removeFromCart(int productId) {
    final updatedCart = state.cartItems.where((item) => item.id != productId).toList();
    emit(CartState(cartItems: updatedCart));
  }

  void increaseQuantity(int productId) {
    final updatedCart = List<CartModel>.from(state.cartItems);
    final index = updatedCart.indexWhere((item) => item.id == productId);
    if (index != -1) {
      final updatedItem = updatedCart[index]
          .copyWith(quantity: updatedCart[index].quantity + 1);
      updatedCart[index] = updatedItem;
      emit(CartState(cartItems: updatedCart));
    }
  }

  void decreaseQuantity(int productId) {
    final updatedCart = List<CartModel>.from(state.cartItems);
    final index = updatedCart.indexWhere((item) => item.id == productId);
    if (index != -1) {
      final currentQty = updatedCart[index].quantity;
      if (currentQty > 1) {
        final updatedItem = updatedCart[index].copyWith(quantity: currentQty - 1);
        updatedCart[index] = updatedItem;
        emit(CartState(cartItems: updatedCart));
      } else {
        updatedCart.removeAt(index);
        emit(CartState(cartItems: updatedCart));
      }
    }
  }

  void clearCart() {
    emit(CartState(cartItems: []));
  }
}
