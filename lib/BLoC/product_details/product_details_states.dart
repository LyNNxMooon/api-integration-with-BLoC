import 'package:bloc_api/data/vos/item_vo.dart';

abstract class ProductDetailStates {}

class ProductInitial extends ProductDetailStates {}

class ProductLoading extends ProductDetailStates {}

class ProductError extends ProductDetailStates {
  final String message;
  ProductError(this.message);
}

class ProductLoaded extends ProductDetailStates {
  final ItemVO product;

  ProductLoaded(this.product);
}
