// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:bloc_api/network/api/api.dart';
import 'package:bloc_api/network/data_agent/data_agent.dart';
import 'package:bloc_api/network/response/register_error_response.dart';
import 'package:bloc_api/network/response/register_response.dart';
import 'package:dio/dio.dart';

class DataAgentImpl extends DataAgent {
  late Api _api;

  DataAgentImpl._() {
    _api = Api(Dio());
  }

  static final DataAgentImpl _singleton = DataAgentImpl._();
  factory DataAgentImpl() => _singleton;

  @override
  Future<RegisterResponse> registerUserAccount(String name, String phone,
      String password, String fcm, String confirmPassword) {
    // TODO: implement registerUserAccount
    throw UnimplementedError();
  }

  Object throwException(dynamic error) {
    if (error is DioException) {
      if (error.type == DioExceptionType.connectionError ||
          error.type == DioExceptionType.receiveTimeout ||
          error.type == DioExceptionType.connectionTimeout ||
          error.type == DioExceptionType.sendTimeout) {
        return "Unable to connect to the server. Please check your internet connection and try again.";
      }
      if (error.response?.data is Map<String, dynamic>) {
        try {
          print(error.response?.data);

          final errorResponse = RegisterErrorResponse.fromJson(
              jsonDecode(error.response.toString()));
          return errorResponse.message;
        } catch (error) {
          return error.toString();
        }
      }
      return error.response.toString();
    }
    return error.toString();
  }
}
