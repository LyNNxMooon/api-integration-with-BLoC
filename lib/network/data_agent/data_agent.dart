import 'package:bloc_api/data/vos/banner_vo.dart';
import 'package:bloc_api/data/vos/item_image_vo.dart';
import 'package:bloc_api/data/vos/item_vo.dart';
import 'package:bloc_api/data/vos/user_vo.dart';
import 'package:bloc_api/network/response/cart_response.dart';
import 'package:bloc_api/network/response/cart_add_update_and_remove_response.dart';

import 'package:bloc_api/network/response/item_response.dart';
import 'package:bloc_api/network/response/logout_response.dart';
import 'package:bloc_api/network/response/login_register_response.dart';

abstract class DataAgent {
  Future<LoginRegisterResponse> registerUserAccount(String name, String phone,
      String password, String fcm, String confirmPassword);

  Future<UserVO> getCurrentUser(String token);

  Future<LogoutResponse> logoutUser(String token);

  Future<LoginRegisterResponse> loginUserAccount(
      String emailOrPhone, String password, String fcm);

  Future<ItemResponse> getProducts(String token, int page, int limit);

  Future<CartResponse> getUserCart(String token);

  Future<CartAddUpdateAndRemoveResponse> updateCart(
      String token, int cartID, int qty);

  Future<CartAddUpdateAndRemoveResponse> removeCart(String token, int cartID);

  Future<CartAddUpdateAndRemoveResponse> clearCart(String token);

  Future<CartAddUpdateAndRemoveResponse> addToCart(
      String token, int productID, int qty);

  Future<List<BannerVO>> getBanners(String token);

  Future<ItemVO> getProductDetails(String token, int productID);

  Future<List<ItemImageVO>> getProductImages(String token, int productID);
}
