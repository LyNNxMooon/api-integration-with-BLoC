import 'package:bloc_api/data/vos/banner_vo.dart';

abstract class BannerStates {}

class BannersInitial extends BannerStates {}

class BannersLoading extends BannerStates {}

class BannersError extends BannerStates {
  final String message;

  BannersError(this.message);
}

class BannersLoaded extends BannerStates {
  final List<BannerVO> banners;

  BannersLoaded(this.banners);
}
