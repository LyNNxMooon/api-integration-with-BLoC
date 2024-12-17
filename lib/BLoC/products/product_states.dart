import 'package:bloc_api/network/response/item_response.dart';

abstract class ProductsStates {}

class ProductsInitial extends ProductsStates {}

class ProductsLoading extends ProductsStates {}

class ProductsError extends ProductsStates {
  final String message;
  ProductsError(this.message);
}

class ProductsLoaded extends ProductsStates {
  final ItemResponse products;

  ProductsLoaded(this.products);
}
