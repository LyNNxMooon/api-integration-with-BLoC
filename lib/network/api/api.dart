import 'package:bloc_api/data/vos/cart_item_vo.dart';
import 'package:bloc_api/network/api_constant.dart';
import 'package:bloc_api/network/response/banner_response.dart';
import 'package:bloc_api/network/response/cart_add_and_update_response.dart';
import 'package:bloc_api/network/response/cart_removed_response.dart';

import 'package:bloc_api/network/response/item_detail_response.dart';
import 'package:bloc_api/network/response/item_image_response.dart';
import 'package:bloc_api/network/response/item_response.dart';
import 'package:bloc_api/network/response/logout_response.dart';
import 'package:bloc_api/network/response/login_register_response.dart';
import 'package:bloc_api/network/response/user_response.dart';

import 'package:retrofit/http.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/error_logger.dart';
part 'api.g.dart';

@RestApi(baseUrl: kBaseURL)
abstract class Api {
  factory Api(Dio dio) => _Api(dio);

  @POST(kEndPointForRegister)
  @Headers(<String, dynamic>{
    'Accept': 'application/json',
  })
  Future<LoginRegisterResponse> registerUser(
    @Field(kParamKeyForName) String name,
    @Field(kParamKeyForPhone) String phone,
    @Field(kParamKeyForPassword) String password,
    @Field(kParamKeyForFcm) String fcm,
    @Field(kParamKeyForConfirmPassword) String confirmPassword,
  );

  @POST(kEndPointForLogin)
  @Headers(<String, dynamic>{
    'Accept': 'application/json',
  })
  Future<LoginRegisterResponse> loginUser(
      @Field(kParamKeyForEmailOrPhone) String emailOrPhone,
      @Field(kParamKeyForPassword) String password,
      @Field(kParamKeyForFcm) String fcm);

  @GET(kEndPointForGetCurrentUser)
  @Headers(<String, dynamic>{
    'Accept': 'application/json',
  })
  Future<UserResponse> getCurrentUser(@Header(kAuthorizationKey) String token);

  @GET(kEndPointForLogout)
  @Headers(<String, dynamic>{
    'Accept': 'application/json',
  })
  Future<LogoutResponse> logoutUser(@Header(kAuthorizationKey) String token);

  @GET(kEndPointForProducts)
  @Headers(<String, dynamic>{
    'Accept': 'application/json',
  })
  Future<ItemResponse> getProducts(
      @Header(kAuthorizationKey) String token,
      @Query(kQueryParamKeyForPage) int page,
      @Query(kQueryParamKeyForLimit) int limit);

  @GET(kEndPointForBanners)
  @Headers(<String, dynamic>{
    'Accept': 'application/json',
  })
  Future<BannerResponse> getBanners(
    @Header(kAuthorizationKey) String token,
  );

  @GET(kEndPointForProductDetails)
  @Headers(<String, dynamic>{
    'Accept': 'application/json',
  })
  Future<ItemDetailResponse> getProductDetails(
      @Header(kAuthorizationKey) String token,
      @Path(kPathParamKeyForProductID) int productID);

  @GET(kEndPointForGetProductImages)
  @Headers(<String, dynamic>{
    'Accept': 'application/json',
  })
  Future<ItemImageResponse> getProductImages(
      @Header(kAuthorizationKey) String token,
      @Path(kPathParamKeyForProductID) int productID);

  @GET(kEndPointForGetCart)
  @Headers(<String, dynamic>{
    'Accept': 'application/json',
  })
  Future<List<CartItemVO>> getUserCart(
    @Header(kAuthorizationKey) String token,
  );

  @POST(kEndPointForAddToCart)
  @Headers(<String, dynamic>{
    'Accept': 'application/json',
  })
  Future<CartAddAndUpdateResponse> addToCart(
      @Header(kAuthorizationKey) String token,
      @Query(kParamKeyForProductID) int productID,
      @Query(kParamKeyForQuantity) int qty);

  @POST(kEndPointForUpdateCart)
  @Headers(<String, dynamic>{
    'Accept': 'application/json',
  })
  Future<CartAddAndUpdateResponse> updateCart(
      @Header(kAuthorizationKey) String token,
      @Path(kPathParamKeyForCartID) int cartID,
      @Query(kParamKeyForQuantity) int qty);

  @DELETE(kEndPointForRemoveCart)
  @Headers(<String, dynamic>{
    'Accept': 'application/json',
  })
  Future<CartRemovedResponse> removeCart(
    @Header(kAuthorizationKey) String token,
    @Path(kPathParamKeyForCartID) int cartID,
  );
}
