import 'package:bloc_api/network/api_constant.dart';
import 'package:bloc_api/network/response/cart_response.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
part 'api_v1.g.dart';

@RestApi(baseUrl: kBaseURL1)
abstract class ApiV1 {
  factory ApiV1(Dio dio) => _ApiV1(dio);

  @GET(kEndPointForGetCart)
  @Headers(<String, dynamic>{
    'Accept': 'application/json',
  })
  Future<CartResponse> getCart(
    @Header(kAuthorizationKey) String token,
  );
}
