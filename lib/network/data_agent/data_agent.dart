import 'package:bloc_api/data/vos/user_vo.dart';
import 'package:bloc_api/network/response/register_response.dart';

abstract class DataAgent {
  Future<RegisterResponse> registerUserAccount(String name, String phone,
      String password, String fcm, String confirmPassword);

  Future<UserVO> getCurrentUser(String token);
}
