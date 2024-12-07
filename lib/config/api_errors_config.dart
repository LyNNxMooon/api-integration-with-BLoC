// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:bloc_api/network/response/login_register_error_response.dart';
import 'package:bloc_api/network/response/user_and_logout_error_response.dart';
import 'package:dio/dio.dart';

class ApiErrorsConfig {
  Object throwExceptionForLoginRegister(dynamic error) {
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

          final errorResponse = LoginRegisterErrorResponse.fromJson(
              jsonDecode(error.response.toString()));
          List<String> errorList = <String>[];
          String message = '';
          if (errorResponse.errors.emailOrPhone != null) {
            errorList.add(errorResponse.errors.emailOrPhone![0]);
          }
          if (errorResponse.errors.name != null) {
            errorList.add(errorResponse.errors.name![0]);
          }

          if (errorResponse.errors.phone != null) {
            errorList.add(errorResponse.errors.phone![0]);
          }

          if (errorResponse.errors.password != null) {
            errorList.add(errorResponse.errors.password![0]);
          }

          if (errorResponse.errors.fcmKey != null) {
            errorList.add(errorResponse.errors.fcmKey![0]);
          }

          for (int i = 0; i < errorList.length; i++) {
            message = "$message\n${errorList[i]}";
          }
          return message;
        } catch (error) {
          return error.toString();
        }
      }
      return error.response.toString();
    }
    return error.toString();
  }

  Object throwExceptionForGetCurrentUserAndLogout(dynamic error) {
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

          final errorResponse = UserAndLogOutErrorResponse.fromJson(
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
