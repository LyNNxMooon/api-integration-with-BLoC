import 'package:bloc_api/data/vos/item_vo.dart';

abstract class ProductRepo {
  Future<List<ItemVO>> getProducts(String token);
}
