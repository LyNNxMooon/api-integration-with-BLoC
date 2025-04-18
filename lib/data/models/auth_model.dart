import 'package:bloc_api/data/vos/user_vo.dart';
import 'package:bloc_api/domain/auth_repository.dart';
import 'package:bloc_api/network/data_agent/data_agent.dart';
import 'package:bloc_api/network/data_agent/data_agent_impl.dart';
import 'package:bloc_api/network/response/logout_response.dart';
import 'package:bloc_api/network/response/login_register_response.dart';

class AuthModel implements AuthRepo {
  AuthModel._();
  static final AuthModel _singleton = AuthModel._();
  factory AuthModel() => _singleton;

  final DataAgent _dataAgent = DataAgentImpl();

  @override
  Future<LoginRegisterResponse> registerUser(String name, String phone,
      String password, String fcm, String confirmPassword) async {
    try {
      return await _dataAgent
          .registerUserAccount(name, phone, password, fcm, confirmPassword)
          .then(
        (value) {
          var temp = value;
          temp.data.isBanned =
              (temp.data.isBanned?.isEmpty ?? true) ? "0" : temp.data.isBanned;

          return temp;
        },
      );
    } on Exception catch (error) {
      return Future.error(error);
    }
  }

  @override
  Future<UserVO> getCurrentUser(String token) async {
    try {
      return await _dataAgent.getCurrentUser(token);
    } on Exception catch (error) {
      return Future.error(error);
    }
  }

  @override
  Future<LogoutResponse> logoutUser(String token) async {
    try {
      return await _dataAgent.logoutUser(token);
    } on Exception catch (error) {
      return Future.error(error);
    }
  }

  @override
  Future<LoginRegisterResponse> loginUser(
      String emailOrPhone, String password, String fcmToken) async {
    try {
      return await _dataAgent.loginUserAccount(
          emailOrPhone, password, fcmToken);
    } on Exception catch (error) {
      return Future.error(error);
    }
  }
}
