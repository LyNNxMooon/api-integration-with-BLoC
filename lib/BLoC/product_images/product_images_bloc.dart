import 'package:bloc_api/BLoC/product_images/product_images_events.dart';
import 'package:bloc_api/BLoC/product_images/product_images_states.dart';
import 'package:bloc_api/data/models/hive_model.dart';
import 'package:bloc_api/domain/product_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductImagesBloc extends Bloc<ProductImagesEvent, ProductImagesStates> {
  final ProductRepo productRepo;

  ProductImagesBloc({required this.productRepo})
      : super(ProductImagesInitial()) {
    on<FetchProductImages>(_onFetchProductImages);
  }

  final _hiveModel = HiveModel();

  Future<void> _onFetchProductImages(
      FetchProductImages event, Emitter<ProductImagesStates> emit) async {
    emit(ProductImagesLoading());
    try {
      final productImagesResponse = await productRepo.getProductImages(
          _hiveModel.getUserToken(), event.productID);

      emit(ProductImagesLoaded(productImagesResponse));
    } catch (error) {
      emit(ProductImagesError("Error fetching product images: $error"));
    }
  }
}
