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

class UpdateQtyError extends ProductDetailStates {
  final String message;
  final int qty;
  final ItemVO product;
  UpdateQtyError(this.message, this.product, this.qty);
}

class UpdateQtySuccess extends ProductDetailStates {
  final ItemVO product;
  final int updatedQty;

  UpdateQtySuccess(this.product, this.updatedQty);
}
