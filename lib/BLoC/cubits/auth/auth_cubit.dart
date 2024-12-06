import 'package:bloc_api/BLoC/cubits/auth/auth_states.dart';
import 'package:bloc_api/data/models/hive_model.dart';
import 'package:bloc_api/data/vos/user_vo.dart';
import 'package:bloc_api/domain/auth_repository.dart';
import 'package:bloc_api/network/response/register_response.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthStates> {
  final AuthRepo authRepo;

  UserVO? _currentUser;

  AuthCubit({required this.authRepo}) : super(AuthInitial());

  final _hiveModel = HiveModel();

  void checkAuth() async {
    final UserVO? user =
        await authRepo.getCurrentUser(_hiveModel.getUserToken());

    if (user != null) {
      _currentUser = user;
      emit(Authenticated(user));
    } else {
      emit(Unauthenticated());
    }
  }

  //Get current User

  UserVO? get currentUser => _currentUser;

  //Register user

  Future<void> registerUser(String name, String phone, String password,
      String confirmPassword, BuildContext context) async {
    try {
      emit(AuthLoading());

      final RegisterResponse response = await authRepo.registerUser(
          name, phone, password, "", confirmPassword);

      _currentUser = response.data;
      _hiveModel.saveUserToken(response.token);
      emit(Authenticated(response.data));
    } catch (error) {
      emit(AuthError(error.toString()));
      emit(Unauthenticated());
    }
  }
}
