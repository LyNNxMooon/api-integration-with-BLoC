abstract class ProductsEvent {}

class FetchProducts extends ProductsEvent {
  final String status;

  FetchProducts({required this.status});
}
