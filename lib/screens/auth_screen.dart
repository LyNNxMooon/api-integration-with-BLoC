import 'package:bloc_api/screens/login_screen.dart';
import 'package:bloc_api/screens/register_screen.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLoginScreen = true;

  void toggleScreens() {
    setState(() {
      isLoginScreen = !isLoginScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoginScreen) {
      return LoginPage(
        toggleScreens: toggleScreens,
      );
    } else {
      return RegisterPage(
        toggleScreens: toggleScreens,
      );
    }
  }
}
