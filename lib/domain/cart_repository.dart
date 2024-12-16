import 'package:bloc_api/network/response/cart_response.dart';
import 'package:bloc_api/network/response/cart_update_and_remove_response.dart';

abstract class CartRepo {
  Future<CartResponse> getUserCart(String token);
  Future<CartUpdateAndRemoveResponse> updateCart(
      String token, int cartID, int qty);
}
