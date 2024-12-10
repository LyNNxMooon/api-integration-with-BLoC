import 'package:bloc_api/network/response/item_response.dart';

abstract class ProductRepo {
  Future<ItemResponse> getProducts(String token, int page, int limit);
}