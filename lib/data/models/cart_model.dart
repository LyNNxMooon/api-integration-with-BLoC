import 'package:bloc_api/domain/cart_repository.dart';
import 'package:bloc_api/network/data_agent/data_agent.dart';
import 'package:bloc_api/network/data_agent/data_agent_impl.dart';
import 'package:bloc_api/network/response/cart_response.dart';
import 'package:bloc_api/network/response/cart_update_and_remove_response.dart';

class CartModel implements CartRepo {
  CartModel._();
  static final CartModel _singleton = CartModel._();
  factory CartModel() => _singleton;

  final DataAgent _dataAgent = DataAgentImpl();
  @override
  Future<CartResponse> getUserCart(String token) async {
    try {
      return await _dataAgent.getUserCart(token).then(
        (value) {
          var temp = value;
          temp.tax = (temp.tax?.isEmpty ?? true) ? " - " : temp.tax;
          temp.taxAmount = temp.taxAmount ?? 0;
          temp.grandTotal = temp.grandTotal ?? 0;
          return temp;
        },
      );
    } on Exception catch (error) {
      return Future.error(error);
    }
  }

  @override
  Future<CartUpdateAndRemoveResponse> updateCart(
      String token, int cartID, int qty) async {
    try {
      return await _dataAgent.updateCart(token, cartID, qty);
    } on Exception catch (error) {
      return Future.error(error);
    }
  }

  @override
  Future<CartUpdateAndRemoveResponse> clearCart(String token) async {
    try {
      return await _dataAgent.clearCart(token);
    } on Exception catch (error) {
      return Future.error(error);
    }
  }

  @override
  Future<CartUpdateAndRemoveResponse> removeCart(
      String token, int cartID) async {
    try {
      return await _dataAgent.removeCart(token, cartID);
    } on Exception catch (error) {
      return Future.error(error);
    }
  }
}
