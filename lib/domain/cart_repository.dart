import 'package:bloc_api/data/vos/cart_item_vo.dart';
import 'package:bloc_api/network/response/cart_removed_response.dart';

import 'package:bloc_api/network/response/cart_add_and_update_response.dart';

abstract class CartRepo {
  Future<List<CartItemVO>> getUserCart(String token);

  Future<CartAddAndUpdateResponse> updateCart(
      String token, int cartID, int qty);

  Future<CartRemovedResponse> removeCart(String token, int cartID);



  Future<CartAddAndUpdateResponse> addToCart(
      String token, int productID, int qty);
}
