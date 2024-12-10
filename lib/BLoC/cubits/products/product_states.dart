import 'package:bloc_api/data/vos/item_vo.dart';

abstract class ProductsStates {}

class ProductsInitial extends ProductsStates {}

class ProductsLoading extends ProductsStates {}

class ProductsError extends ProductsStates {
  final String message;
  ProductsError(this.message);
}

class ProductsLoaded extends ProductsStates {
  final List<ItemVO> products;

  ProductsLoaded(this.products);
}
