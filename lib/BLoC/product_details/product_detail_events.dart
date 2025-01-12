import 'package:bloc_api/data/vos/item_vo.dart';

abstract class ProductDetailEvent {}

class FetchProductDetail extends ProductDetailEvent {
  int productID;

  FetchProductDetail({required this.productID});
}

class IncreaseQty extends ProductDetailEvent {
  ItemVO product;

  IncreaseQty({required this.product});
}

class DecreaseQty extends ProductDetailEvent {
  ItemVO product;

  DecreaseQty({required this.product});
}
