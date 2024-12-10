import 'package:bloc_api/BLoC/cubits/products/product_states.dart';
import 'package:bloc_api/data/models/hive_model.dart';
import 'package:bloc_api/domain/product_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsCubit extends Cubit<ProductsStates> {
  final ProductRepo productRepo;

  ProductsCubit({required this.productRepo}) : super(ProductsInitial());

  final _hiveModel = HiveModel();
  int page = 1;
  int limit = 10;

  Future<void> getAllProducts() async {
    emit(ProductsLoading());
    try {
      final productsResponse =
          await productRepo.getProducts(_hiveModel.getUserToken(), page, limit);

      productsResponse.loadMore ? ++page : page = 1;
      emit(ProductsLoaded(productsResponse.data));
    } catch (error) {
      emit(ProductsError("Error fetching products: $error"));
    }
  }
}
