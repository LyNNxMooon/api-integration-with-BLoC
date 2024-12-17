import 'package:bloc_api/network/response/cart_response.dart';
import 'package:bloc_api/network/response/cart_add_update_and_remove_response.dart';

abstract class CartStates {}

class CartInitial extends CartStates {}

class CartLoading extends CartStates {}

class CartErrors extends CartStates {
  final String message;
  CartErrors(this.message);
}

class CartLoaded extends CartStates {
  final CartResponse cart;

  CartLoaded(this.cart);
}

class CartAdded extends CartStates {
  final CartAddUpdateAndRemoveResponse addedResponse;

  CartAdded(this.addedResponse);
}

class CartUpdated extends CartStates {
  final CartAddUpdateAndRemoveResponse updateResponse;

  CartUpdated(this.updateResponse);
}

class CartRemoved extends CartStates {
  final CartAddUpdateAndRemoveResponse removeResponse;

  CartRemoved(this.removeResponse);
}
