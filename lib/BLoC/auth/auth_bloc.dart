// ignore_for_file: use_build_context_synchronously

import 'package:bloc_api/BLoC/auth/auth_events.dart';
import 'package:bloc_api/BLoC/auth/auth_states.dart';
import 'package:bloc_api/data/models/hive_model.dart';
import 'package:bloc_api/data/vos/user_vo.dart';
import 'package:bloc_api/domain/auth_repository.dart';
import 'package:bloc_api/network/response/logout_response.dart';
import 'package:bloc_api/network/response/login_register_response.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Bloc<AuthEvents, AuthStates> {
  final AuthRepo authRepo;

  UserVO? _currentUser;

  AuthCubit({required this.authRepo}) : super(AuthInitial()) {
    on<CheckUserAuth>(_checkAuth);
    on<RegisterEvent>(_registerUser);
    on<LoginEvent>(_loginUser);
    on<LogoutEvent>(_logoutUser);
  }

  final _hiveModel = HiveModel();

  void _checkAuth(CheckUserAuth event, Emitter<AuthStates> emit) async {
    try {
      final UserVO user =
          await authRepo.getCurrentUser(_hiveModel.getUserToken());

      _currentUser = user;
      emit(Authenticated(user));
    } catch (error) {
      emit(AuthError(error.toString()));
      emit(Unauthenticated());
    }
  }

  //Get current User

  UserVO? get currentUser => _currentUser;

  //Register user

  Future<void> _registerUser(
    RegisterEvent event,
    Emitter<AuthStates> emit,
  ) async {
    try {
      emit(AuthLoading());

      final LoginRegisterResponse response = await authRepo.registerUser(
          event.name,
          event.phone,
          event.password,
          "fcm token",
          event.confirmPassword);

      _currentUser = response.data;
      _hiveModel.saveUserToken(response.token);
      emit(Authenticated(response.data));
    } catch (error) {
      emit(AuthError(error.toString()));
      emit(Unauthenticated());
    }
  }

  //login

  Future<void> _loginUser(LoginEvent event, Emitter<AuthStates> emit) async {
    try {
      emit(AuthLoading());

      final LoginRegisterResponse response = await authRepo.loginUser(
          event.emailOrPhone, event.password, "fcm token");

      _currentUser = response.data;
      _hiveModel.saveUserToken(response.token);
      emit(Authenticated(response.data));
    } catch (error) {
      emit(AuthError(error.toString()));
      emit(Unauthenticated());
    }
  }

  //logout

  Future<void> _logoutUser(LogoutEvent event, Emitter<AuthStates> emit) async {
    try {
      emit(AuthLoading());

      final LogoutResponse response =
          await authRepo.logoutUser(_hiveModel.getUserToken());

      emit(AuthError(response.message));
      emit(Unauthenticated());
    } catch (error) {
      emit(AuthError(error.toString()));
      emit(Authenticated(currentUser ??
          UserVO(
              id: 0,
              name: "",
              phone: "",
              imgURL: "",
              email: "",
              fcm: "",
              isBanned: "",
              createdAt: "")));
    }
  }
}
