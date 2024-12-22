import 'package:bloc_api/BLoC/banner/banner_events.dart';
import 'package:bloc_api/BLoC/banner/banner_states.dart';
import 'package:bloc_api/data/models/hive_model.dart';
import 'package:bloc_api/domain/product_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BannerBloc extends Bloc<BannerEvents, BannerStates> {
  final ProductRepo productRepo;

  BannerBloc({required this.productRepo}) : super(BannersInitial()) {
    on<FetchBanners>(_onFetchBanners);
  }

  final _hiveModel = HiveModel();

  Future<void> _onFetchBanners(
      FetchBanners event, Emitter<BannerStates> emit) async {
    emit(BannersLoading());
    try {
      final bannerResponse =
          await productRepo.getBanners(_hiveModel.getUserToken());

      emit(BannersLoaded(bannerResponse));
    } catch (error) {
      emit(BannersError("Error fetching banners: $error"));
    }
  }
}
