import 'package:bloc_api/data/vos/user_vo.dart';

abstract class AuthStates {}

class AuthInitial extends AuthStates {}

class AuthLoading extends AuthStates {}

class Authenticated extends AuthStates {
  final UserVO user;
  Authenticated(this.user);
}

class Unauthenticated extends AuthStates {}

class AuthError extends AuthStates {
  final String message;
  AuthError(this.message);
}
