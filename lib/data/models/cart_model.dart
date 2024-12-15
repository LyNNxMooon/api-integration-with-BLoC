import 'package:bloc_api/domain/cart_repository.dart';
import 'package:bloc_api/network/data_agent/data_agent.dart';
import 'package:bloc_api/network/data_agent/data_agent_impl.dart';
import 'package:bloc_api/network/response/cart_response.dart';

class CartModel implements CartRepo {
  CartModel._();
  static final CartModel _singleton = CartModel._();
  factory CartModel() => _singleton;

  final DataAgent _dataAgent = DataAgentImpl();
  @override
  Future<CartResponse> getUserCart(String token) async {
    try {
      return await _dataAgent.getUserCart(token);
    } on Exception catch (error) {
      return Future.error(error);
    }
  }
}
