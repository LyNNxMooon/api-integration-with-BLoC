abstract class ProductImagesEvent {}

class FetchProductImages extends ProductImagesEvent {
  int productID;

  FetchProductImages({required this.productID});
}
