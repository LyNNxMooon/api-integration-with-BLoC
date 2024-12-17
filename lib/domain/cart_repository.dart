import 'package:bloc_api/network/response/cart_response.dart';
import 'package:bloc_api/network/response/cart_add_update_and_remove_response.dart';

abstract class CartRepo {
  Future<CartResponse> getUserCart(String token);

  Future<CartAddUpdateAndRemoveResponse> updateCart(
      String token, int cartID, int qty);

  Future<CartAddUpdateAndRemoveResponse> removeCart(String token, int cartID);

  Future<CartAddUpdateAndRemoveResponse> clearCart(String token);

  Future<CartAddUpdateAndRemoveResponse> addToCart(
      String token, int productID, int qty);
}
