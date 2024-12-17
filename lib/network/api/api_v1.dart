import 'package:bloc_api/network/api_constant.dart';
import 'package:bloc_api/network/response/cart_response.dart';
import 'package:bloc_api/network/response/cart_add_update_and_remove_response.dart';
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

  @POST(kEndPointForAddToCart)
  @Headers(<String, dynamic>{
    'Accept': 'application/json',
  })
  Future<CartAddUpdateAndRemoveResponse> addToCart(
    @Header(kAuthorizationKey) String token,
    @Field(kParamKeyForProductID) int productID,
    @Field(kParamKeyForQuantity) int qty,
  );

  @PUT(kEndPointForUpdateCart)
  @Headers(<String, dynamic>{
    'Accept': 'application/json',
  })
  @FormUrlEncoded()
  Future<CartAddUpdateAndRemoveResponse> updateCart(
      @Header(kAuthorizationKey) String token,
      @Path(kPathParamKeyForCartID) int cartID,
      @Field(kParamKeyForQuantity) int qty);

  @DELETE(kEndPointForRemoveCart)
  @Headers(<String, dynamic>{
    'Accept': 'application/json',
  })
  Future<CartAddUpdateAndRemoveResponse> removeCart(
    @Header(kAuthorizationKey) String token,
    @Path(kPathParamKeyForCartID) int cartID,
  );

  @DELETE(kEndPointForClearCart)
  @Headers(<String, dynamic>{
    'Accept': 'application/json',
  })
  Future<CartAddUpdateAndRemoveResponse> clearCart(
    @Header(kAuthorizationKey) String token,
  );
}
