import 'package:bloc_api/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:bloc_api/constants/colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.hintText,
      required this.label,
      this.isObscure,
      this.suffixIcon,
      this.validator,
      this.keyboardType,
      required this.controller});

  final String hintText;
  final String label;
  final bool? isObscure;
  final IconButton? suffixIcon;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final Validator? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        obscureText: isObscure ?? false,
        controller: controller,
        keyboardType: keyboardType,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: validator != null
            ? () {
                switch (validator) {
                  case Validator.email:
                    return (value) => TextFieldValidator.email(value);

                  case Validator.phone:
                    return (value) => TextFieldValidator.phone(value, context);
                  case Validator.password:
                    return (value) =>
                        TextFieldValidator.password(value, context);
                  default:
                    return (value) => TextFieldValidator.defaultEnterV(value);
                }
              }()
            : null,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          hintText: hintText,
          labelText: label,
          labelStyle: const TextStyle(color: kFourthColor),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 2, color: kThirdColor),
              borderRadius: BorderRadius.circular(10)),
          border: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: kFourthColor),
              borderRadius: BorderRadius.circular(10)),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 1, color: kFourthColor),
              borderRadius: BorderRadius.circular(10)),
        ));
  }
}

class TextFieldValidator {
  static String? password(String? psw, BuildContext context) {
    RegExp regExpForSymbol = RegExp(r'[!@#$%^&*(),.?":{}|<>]');
    RegExp regExpForNumber = RegExp(r'(?=.*?[0-9])');
    RegExp regExpForCapital = RegExp(r'(?=.*?[A-Z])');

    if (psw!.isEmpty) {
      return 'Please enter password !';
    } else if (psw.length < 10) {
      return "Password must be at least 10 digits";
    } else if (!regExpForSymbol.hasMatch(psw)) {
      return "Password must contain at least 1 symbol!";
    } else if (!regExpForNumber.hasMatch(psw)) {
      return "Password must contain at least 1 number!";
    } else if (!regExpForCapital.hasMatch(psw)) {
      return "Password must contain at least 1 Capital letter!";
    }
    return null;
  }

  static String? phone(String? phone, BuildContext context) {
    String pattern = r'^(?:[+0]9)?[0-9]{9,12}$';

    RegExp regExp = RegExp(
      pattern,
    );
    if (phone!.isEmpty) {
      return 'Please enter Phone Number !';
    } else if (!regExp.hasMatch(phone)) {
      return "Please enter validate Phone Number !";
    } else {}
    return null;
  }

  static String? email(String? email) {
    RegExp regExp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (email!.isEmpty) {
      return null;
    } else if (!regExp.hasMatch(email)) {
      return "Please enter valid email !";
    }
    return null;
  }

  static String? defaultEnterV([dynamic value, String? validateName]) {
    if (value is String && value.isEmpty) {
      return '$validateName';
    }
    return null;
  }
}
