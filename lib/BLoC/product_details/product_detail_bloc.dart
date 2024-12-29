import 'package:bloc_api/BLoC/product_details/product_detail_events.dart';
import 'package:bloc_api/BLoC/product_details/product_details_states.dart';
import 'package:bloc_api/data/models/hive_model.dart';
import 'package:bloc_api/domain/product_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailStates> {
  final ProductRepo productRepo;

  ProductDetailBloc({required this.productRepo}) : super(ProductInitial()) {
    on<FetchProductDetail>(_onFetchProductDetails);
  }

  final _hiveModel = HiveModel();

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
}
