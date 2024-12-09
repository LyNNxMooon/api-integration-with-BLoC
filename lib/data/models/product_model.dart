import 'package:bloc_api/data/vos/item_vo.dart';
import 'package:bloc_api/domain/product_repository.dart';

class ProductModel implements ProductRepo {
  @override
  Future<List<ItemVO>> getProducts(String token) {
    // TODO: implement getProducts
    throw UnimplementedError();
  }
}
