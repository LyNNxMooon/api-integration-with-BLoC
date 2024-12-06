import 'package:bloc_api/network/api_constant.dart';
import 'package:bloc_api/network/response/register_response.dart';
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
  Future<RegisterResponse> registerUser(
    @Field(kParamKeyForName) String name,
    @Field(kParamKeyForPhone) String phone,
    @Field(kParamKeyForNewPassword) String password,
    @Field(kParamKeyForFcm) String fcm,
    @Field(kParamKeyForConfirmPassword) String confirmPassword,
  );

  @GET(kEndPointForGetCurrentUser)
  @Headers(<String, dynamic>{
    'Accept': 'application/json',
  })
  Future<UserResponse> getCurrentUser(@Header(kAuthorizationKey) String token);
}
