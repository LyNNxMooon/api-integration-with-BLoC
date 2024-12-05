import 'package:bloc_api/network/response/register_response.dart';

abstract class AuthRepo {
  Future<RegisterResponse> registerUser(String name, String phone,
      String password, String fcmToken, String confirmPassword);
}
