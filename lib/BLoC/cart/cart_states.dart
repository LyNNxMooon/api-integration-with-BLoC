import 'package:bloc_api/data/vos/cart_item_vo.dart';
import 'package:bloc_api/network/response/cart_removed_response.dart';

import 'package:bloc_api/network/response/cart_add_and_update_response.dart';

abstract class CartStates {}

class CartInitial extends CartStates {}

class CartLoading extends CartStates {}

class CartErrors extends CartStates {
  final String message;
  CartErrors(this.message);
}

class CartLoaded extends CartStates {
  final List<CartItemVO> cart;

  CartLoaded(this.cart);
}

class CartAdded extends CartStates {
  final CartAddAndUpdateResponse addedResponse;

  CartAdded(this.addedResponse);
}

class CartUpdated extends CartStates {
  final CartAddAndUpdateResponse updateResponse;

  CartUpdated(this.updateResponse);
}

class CartRemoved extends CartStates {
  final CartRemovedResponse removeResponse;

  CartRemoved(this.removeResponse);
}
