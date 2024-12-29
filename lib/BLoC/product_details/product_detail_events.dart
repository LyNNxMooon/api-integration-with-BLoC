abstract class ProductDetailEvent {}

class FetchProductDetail extends ProductDetailEvent {
  int productID;

  FetchProductDetail({required this.productID});
}
