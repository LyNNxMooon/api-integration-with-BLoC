// ignore_for_file: avoid_print

import 'package:bloc_api/config/api_errors_config.dart';
import 'package:bloc_api/data/vos/user_vo.dart';
import 'package:bloc_api/network/api/api.dart';
import 'package:bloc_api/network/data_agent/data_agent.dart';
import 'package:bloc_api/network/response/logout_response.dart';

import 'package:bloc_api/network/response/login_register_response.dart';
import 'package:dio/dio.dart';

class DataAgentImpl extends DataAgent {
  late Api _api;

  DataAgentImpl._() {
    _api = Api(Dio());
  }

  static final DataAgentImpl _singleton = DataAgentImpl._();
  factory DataAgentImpl() => _singleton;

  ApiErrorsConfig apiErrorsConfig = ApiErrorsConfig();

  @override
  Future<LoginRegisterResponse> registerUserAccount(String name, String phone,
      String password, String fcm, String confirmPassword) async {
    try {
      return await _api
          .registerUser(name, phone, password, fcm, confirmPassword)
          .asStream()
          .map((event) => event)
          .first;
    } on Exception catch (error) {
      return Future.error(
          apiErrorsConfig.throwExceptionForLoginRegister(error));
    }
  }

  @override
  Future<UserVO> getCurrentUser(String token) async {
    try {
      return await _api
          .getCurrentUser("Bearer $token")
          .asStream()
          .map((event) => event.data)
          .first;
    } on Exception catch (error) {
      return Future.error(
          apiErrorsConfig.throwExceptionForGetCurrentUserAndLogout(error));
    }
  }

  @override
  Future<LogoutResponse> logoutUser(String token) async {
    try {
      return await _api
          .logoutUser("Bearer $token")
          .asStream()
          .map(
            (event) => event,
          )
          .first;
    } on Exception catch (error) {
      return Future.error(
          apiErrorsConfig.throwExceptionForGetCurrentUserAndLogout(error));
    }
  }

  @override
  Future<LoginRegisterResponse> loginUserAccount(
      String emailOrPhone, String password, String fcm) async {
    try {
      return await _api
          .loginUser(emailOrPhone, password, fcm)
          .asStream()
          .map((event) => event)
          .first;
    } on Exception catch (error) {
      return Future.error(
          apiErrorsConfig.throwExceptionForLoginRegister(error));
    }
  }
}
