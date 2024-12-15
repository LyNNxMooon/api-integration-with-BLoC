import 'package:bloc_api/network/response/cart_response.dart';

abstract class CartRepo {
  Future<CartResponse> getUserCart(String token);
}
