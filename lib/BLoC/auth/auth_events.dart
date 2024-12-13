abstract class AuthEvents {}

class CheckUserAuth extends AuthEvents {}

class LoginEvent extends AuthEvents {
  String emailOrPhone;
  String password;

  LoginEvent({required this.emailOrPhone, required this.password});
}

class RegisterEvent extends AuthEvents {
  String name;
  String phone;
  String password;
  String confirmPassword;

  RegisterEvent(
      {required this.name,
      required this.phone,
      required this.password,
      required this.confirmPassword});
}

class LogoutEvent extends AuthEvents {}
