import 'package:bloc_api/data/vos/banner_vo.dart';
import 'package:bloc_api/data/vos/item_image_vo.dart';
import 'package:bloc_api/data/vos/item_vo.dart';
import 'package:bloc_api/network/response/item_response.dart';

abstract class ProductRepo {
  Future<ItemResponse> getProducts(String token, int page, int limit, String status);
  Future<List<BannerVO>> getBanners(String token);
  Future<ItemVO> getProductDetail(String token, int productID);
  Future<List<ItemImageVO>> getProductImages(String token, int productID);
}
