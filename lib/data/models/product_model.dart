import 'package:bloc_api/data/vos/banner_vo.dart';
import 'package:bloc_api/data/vos/item_image_vo.dart';
import 'package:bloc_api/data/vos/item_vo.dart';
import 'package:bloc_api/domain/product_repository.dart';
import 'package:bloc_api/network/data_agent/data_agent.dart';
import 'package:bloc_api/network/data_agent/data_agent_impl.dart';
import 'package:bloc_api/network/response/item_response.dart';

class ProductModel implements ProductRepo {
  ProductModel._();
  static final ProductModel _singleton = ProductModel._();
  factory ProductModel() => _singleton;

  final DataAgent _dataAgent = DataAgentImpl();

  @override
  Future<ItemResponse> getProducts(String token, int page, int limit) async {
    try {
      return await _dataAgent.getProducts(token, page, limit).then(
        (value) {
          var temp = value;
          temp.data = temp.data.map(
            (item) {
              item.barcode =
                  (item.barcode?.isEmpty ?? true) ? " - " : item.barcode;
              item.description = (item.description?.isEmpty ?? true)
                  ? " - "
                  : item.description;
              item.discountedPrice =
                  (item.discountedPrice == null) ? 0 : item.discountedPrice;
              return item;
            },
          ).toList();
          return temp;
        },
      );
    } on Exception catch (error) {
      return Future.error(error);
    }
  }

  @override
  Future<List<BannerVO>> getBanners(String token) async {
    try {
      return await _dataAgent.getBanners(token);
    } on Exception catch (error) {
      return Future.error(error);
    }
  }

  @override
  Future<ItemVO> getProductDetail(String token, int productID) async {
    try {
      return await _dataAgent.getProductDetails(token, productID).then(
        (value) {
          var temp = value;

          temp.barcode = (temp.barcode?.isEmpty ?? true) ? " - " : temp.barcode;
          temp.description =
              (temp.description?.isEmpty ?? true) ? " - " : temp.description;
          temp.discountedPrice =
              (temp.discountedPrice == null) ? 0 : temp.discountedPrice;

          return temp;
        },
      );
    } on Exception catch (error) {
      return Future.error(error);
    }
  }

  @override
  Future<List<ItemImageVO>> getProductImages(
      String token, int productID) async {
    try {
      return await _dataAgent.getProductImages(token, productID);
    } on Exception catch (error) {
      return Future.error(error);
    }
  }
}
