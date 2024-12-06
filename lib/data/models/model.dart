import 'package:bloc_api/data/vos/user_vo.dart';
import 'package:bloc_api/domain/auth_repository.dart';
import 'package:bloc_api/network/data_agent/data_agent.dart';
import 'package:bloc_api/network/data_agent/data_agent_impl.dart';
import 'package:bloc_api/network/response/register_response.dart';

class Model implements AuthRepo {
  Model._();
  static final Model _singleton = Model._();
  factory Model() => _singleton;

  final DataAgent _dataAgent = DataAgentImpl();

  @override
  Future<RegisterResponse> registerUser(String name, String phone,
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
  Future<UserVO?> getCurrentUser(String token) async {
    try {
      return await _dataAgent.getCurrentUser(token);
    } on Exception catch (error) {
      return Future.error(error);
    }
  }
}
