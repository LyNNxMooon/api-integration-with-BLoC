import 'package:bloc_api/network/api_constant.dart';
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
}
