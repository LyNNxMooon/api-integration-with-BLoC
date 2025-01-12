import 'package:bloc_api/BLoC/product_details/product_detail_events.dart';
import 'package:bloc_api/BLoC/product_details/product_details_states.dart';
import 'package:bloc_api/data/models/hive_model.dart';
import 'package:bloc_api/domain/product_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailStates> {
  final ProductRepo productRepo;

  ProductDetailBloc({required this.productRepo}) : super(ProductInitial()) {
    on<FetchProductDetail>(_onFetchProductDetails);
    on<IncreaseQty>(_onIncreaseQty);
    on<DecreaseQty>(_onDecreaseQty);
  }

  final _hiveModel = HiveModel();

  int productQty = 1;

  Future<void> _onFetchProductDetails(
      FetchProductDetail event, Emitter<ProductDetailStates> emit) async {
    emit(ProductLoading());
    try {
      final productResponse = await productRepo.getProductDetail(
          _hiveModel.getUserToken(), event.productID);

      emit(ProductLoaded(productResponse));
    } catch (error) {
      emit(ProductError("Error fetching product detail: $error"));
    }
  }

  Future<void> _onIncreaseQty(
      IncreaseQty event, Emitter<ProductDetailStates> emit) async {
    /*if (int.parse(event.product.instock) >= productQty) {
      emit(UpdateQtyError(
          "Quantity reached to stocks limit!", event.product, productQty));
    } else {
      emit(UpdateQtySuccess(event.product, productQty++));
    } */
    emit(UpdateQtySuccess(event.product, ++productQty));
  }

  Future<void> _onDecreaseQty(
      DecreaseQty event, Emitter<ProductDetailStates> emit) async {
    if (productQty <= 1) {
      emit(UpdateQtyError(
          "Quantity cannot be less than zero!", event.product, productQty));
    } else {
      emit(UpdateQtySuccess(event.product, --productQty));
    }
  }
}
