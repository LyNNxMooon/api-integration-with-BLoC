// ignore_for_file: avoid_print

import 'package:bloc_api/config/api_errors_config.dart';
import 'package:bloc_api/data/vos/banner_vo.dart';
import 'package:bloc_api/data/vos/cart_item_vo.dart';
import 'package:bloc_api/data/vos/item_image_vo.dart';
import 'package:bloc_api/data/vos/item_vo.dart';
import 'package:bloc_api/data/vos/user_vo.dart';
import 'package:bloc_api/network/api/api.dart';

import 'package:bloc_api/network/data_agent/data_agent.dart';
import 'package:bloc_api/network/response/cart_removed_response.dart';

import 'package:bloc_api/network/response/cart_add_and_update_response.dart';
import 'package:bloc_api/network/response/item_response.dart';
import 'package:bloc_api/network/response/logout_response.dart';

import 'package:bloc_api/network/response/login_register_response.dart';
import 'package:dio/dio.dart';

class DataAgentImpl extends DataAgent {
  late Api _api;

  DataAgentImpl._() {
    _api = Api(Dio());
  }

  static final DataAgentImpl _singleton = DataAgentImpl._();
  factory DataAgentImpl() => _singleton;

  ApiErrorsConfig apiErrorsConfig = ApiErrorsConfig();

  @override
  Future<LoginRegisterResponse> registerUserAccount(String name, String phone,
      String password, String fcm, String confirmPassword) async {
    try {
      return await _api
          .registerUser(name, phone, password, fcm, confirmPassword)
          .asStream()
          .map((event) => event)
          .first;
    } on Exception catch (error) {
      return Future.error(apiErrorsConfig.throwExceptionForRegister(error));
    }
  }

  @override
  Future<UserVO> getCurrentUser(String token) async {
    try {
      return await _api
          .getCurrentUser("Bearer $token")
          .asStream()
          .map((event) => event.data)
          .first;
    } on Exception catch (error) {
      return Future.error(
          apiErrorsConfig.throwExceptionForGetCurrentUserAndLogout(error));
    }
  }

  @override
  Future<LogoutResponse> logoutUser(String token) async {
    try {
      return await _api
          .logoutUser("Bearer $token")
          .asStream()
          .map(
            (event) => event,
          )
          .first;
    } on Exception catch (error) {
      return Future.error(
          apiErrorsConfig.throwExceptionForGetCurrentUserAndLogout(error));
    }
  }

  @override
  Future<LoginRegisterResponse> loginUserAccount(
      String emailOrPhone, String password, String fcm) async {
    try {
      return await _api
          .loginUser(emailOrPhone, password, fcm)
          .asStream()
          .map((event) => event)
          .first;
    } on Exception catch (error) {
      return Future.error(apiErrorsConfig.throwExceptionForLogin(error));
    }
  }

  @override
  Future<ItemResponse> getProducts(String token, int page, int limit) async {
    try {
      return await _api
          .getProducts("Bearer $token", page, limit)
          .asStream()
          .map((event) => event)
          .first;
    } on Exception catch (error) {
      return Future.error(apiErrorsConfig.throwExceptionForGetProducts(error));
    }
  }

  @override
  Future<List<CartItemVO>> getUserCart(String token) async {
    try {
      return await _api
          .getUserCart("Bearer $token")
          .asStream()
          .map((event) => event)
          .first;
    } on Exception catch (error) {
      print(error);
      return Future.error(apiErrorsConfig.throwExceptionForCarts(error));
    }
  }

  @override
  Future<CartAddAndUpdateResponse> updateCart(
      String token, int cartID, int qty) async {
    try {
      return await _api
          .updateCart("Bearer $token", cartID, qty)
          .asStream()
          .map(
            (event) => event,
          )
          .first;
    } on Exception catch (error) {
      return Future.error(apiErrorsConfig.throwExceptionForCarts(error));
    }
  }

  @override
  Future<CartRemovedResponse> removeCart(String token, int cartID) async {
    try {
       return await _api
          .removeCart("Bearer $token", cartID)
          .asStream()
          .map(
            (event) => event,
          )
          .first;
    } on Exception catch (error) {
      return Future.error(apiErrorsConfig.throwExceptionForCarts(error));
    }
  }

  @override
  Future<CartAddAndUpdateResponse> addToCart(
      String token, int productID, int qty) async {
    try {
      return await _api
          .addToCart("Bearer $token", productID, qty)
          .asStream()
          .map(
            (event) => event,
          )
          .first;
    } on Exception catch (error) {
      return Future.error(apiErrorsConfig.throwExceptionForCarts(error));
    }
  }

  @override
  Future<List<BannerVO>> getBanners(String token) async {
    try {
      return await _api
          .getBanners("Bearer $token")
          .asStream()
          .map((event) => event.data)
          .first;
    } on Exception catch (error) {
      return Future.error(apiErrorsConfig.throwExceptionForGetBanners(error));
    }
  }

  @override
  Future<ItemVO> getProductDetails(String token, int productID) async {
    try {
      return await _api
          .getProductDetails("Bearer $token", productID)
          .asStream()
          .map((event) => event.data)
          .first;
    } on Exception catch (error) {
      return Future.error(
          apiErrorsConfig.throwExceptionForGetProductAndImage(error));
    }
  }

  @override
  Future<List<ItemImageVO>> getProductImages(
      String token, int productID) async {
    try {
      return await _api
          .getProductImages("Bearer $token", productID)
          .asStream()
          .map((event) => event.data)
          .first;
    } on Exception catch (error) {
      return Future.error(
          apiErrorsConfig.throwExceptionForGetProductAndImage(error));
    }
  }
}
