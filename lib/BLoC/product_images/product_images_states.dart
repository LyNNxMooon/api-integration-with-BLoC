import 'package:bloc_api/data/vos/item_image_vo.dart';

abstract class ProductImagesStates {}

class ProductImagesInitial extends ProductImagesStates {}

class ProductImagesLoading extends ProductImagesStates {}

class ProductImagesError extends ProductImagesStates {
  final String message;
  ProductImagesError(this.message);
}

class ProductImagesLoaded extends ProductImagesStates {
  final List<ItemImageVO> productImages;

  ProductImagesLoaded(this.productImages);
}
