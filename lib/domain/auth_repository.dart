import 'package:bloc_api/data/vos/user_vo.dart';
import 'package:bloc_api/network/response/logout_response.dart';
import 'package:bloc_api/network/response/register_response.dart';

abstract class AuthRepo {
  Future<RegisterResponse> registerUser(String name, String phone,
      String password, String fcmToken, String confirmPassword);

  Future<UserVO> getCurrentUser(String token);

  Future<LogoutResponse> logoutUser(String token);
}
