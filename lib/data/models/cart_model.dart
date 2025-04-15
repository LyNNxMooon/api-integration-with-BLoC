import 'package:bloc_api/data/vos/cart_item_vo.dart';
import 'package:bloc_api/domain/cart_repository.dart';
import 'package:bloc_api/network/data_agent/data_agent.dart';
import 'package:bloc_api/network/data_agent/data_agent_impl.dart';
import 'package:bloc_api/network/response/cart_removed_response.dart';

import 'package:bloc_api/network/response/cart_add_and_update_response.dart';

class CartModel implements CartRepo {
  CartModel._();
  static final CartModel _singleton = CartModel._();
  factory CartModel() => _singleton;

  final DataAgent _dataAgent = DataAgentImpl();
  @override
  Future<List<CartItemVO>> getUserCart(String token) async {
    try {
      return await _dataAgent.getUserCart(token);
    } on Exception catch (error) {
      return Future.error(error);
    }
  }

  @override
  Future<CartAddAndUpdateResponse> updateCart(
      String token, int cartID, int qty) async {
    try {
      return await _dataAgent.updateCart(token, cartID, qty);
    } on Exception catch (error) {
      return Future.error(error);
    }
  }



  @override
  Future<CartRemovedResponse> removeCart(
      String token, int cartID) async {
    try {
      return await _dataAgent.removeCart(token, cartID);
    } on Exception catch (error) {
      return Future.error(error);
    }
  }

  @override
  Future<CartAddAndUpdateResponse> addToCart(
      String token, int productID, int qty) async {
    try {
      return await _dataAgent.addToCart(token, productID, qty);
    } on Exception catch (error) {
      return Future.error(error);
    }
  }
}
