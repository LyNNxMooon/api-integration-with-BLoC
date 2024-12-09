import 'package:bloc_api/data/vos/user_vo.dart';
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
}
