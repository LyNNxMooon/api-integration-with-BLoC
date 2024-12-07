import 'package:bloc_api/data/vos/user_vo.dart';
import 'package:bloc_api/network/response/logout_response.dart';
import 'package:bloc_api/network/response/login_register_response.dart';

abstract class AuthRepo {
  Future<LoginRegisterResponse> registerUser(String name, String phone,
      String password, String fcmToken, String confirmPassword);

  Future<UserVO> getCurrentUser(String token);

  Future<LogoutResponse> logoutUser(String token);

  Future<LoginRegisterResponse> loginUser(
      String emailOrPhone, String password, String fcmToken);
}
