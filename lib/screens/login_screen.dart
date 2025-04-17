import 'package:bloc_api/BLoC/auth/auth_bloc.dart';
import 'package:bloc_api/BLoC/auth/auth_events.dart';
import 'package:bloc_api/constants/colors.dart';
import 'package:bloc_api/constants/texts.dart';
import 'package:bloc_api/widgets/button_widget.dart';
import 'package:bloc_api/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.toggleScreens});

  final void Function()? toggleScreens;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool? showPassword = true;
  final _emailOrPhoneController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailOrPhoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authBloc = context.read<AuthBloc>();
    return SafeArea(
        child: Scaffold(
      backgroundColor: kPrimaryColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: ListView(
          children: [
            Gap(MediaQuery.of(context).size.height * 0.18),
            const Icon(
              Icons.fastfood_outlined,
              color: kFourthColor,
              size: 50,
            ),
            const Gap(20),
            const Center(
              child: Text(
                "Bloc Products",
                style: titleStyle,

              ),
            ),
            const Gap(10),
            const Center(
              child: Text(
                "Login to start",
                style: subtitleStyle,
              ),
            ),
            const Gap(40),
            CustomTextField(
              hintText: "Enter your Email or Phone",
              label: "Email or Phone",
              controller: _emailOrPhoneController,
            ),
            const Gap(20),
            CustomTextField(
              controller: _passwordController,
              hintText: "Enter your Password",
              label: "Password",
              isObscure: showPassword,
              suffixIcon: IconButton(
                  onPressed: () {
                    showPassword = !showPassword!;
                    setState(() {});
                  },
                  icon: showPassword!
                      ? const Icon(
                          Icons.visibility_outlined,
                          color: kThirdColor,
                        )
                      : const Icon(
                          Icons.visibility_off_outlined,
                          color: kThirdColor,
                        )),
            ),
            const Gap(40),
            CustomButton(
              name: "Login",
              function: () => authBloc.add(LoginEvent(
                  emailOrPhone: _emailOrPhoneController.text,
                  password: _passwordController.text)),
            ),
            const Gap(60),
            GestureDetector(
              onTap: widget.toggleScreens,
              child: const Column(
                children: [
                  Icon(
                    Icons.rocket_launch_sharp,
                    color: kSecondaryColor,
                    size: 45,
                  ),
                  Gap(10),
                  Center(
                      child: Text(
                    "Tap to create account",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: kThirdColor),
                  ))
                ],
              ),
            ),
            const Gap(70),
          ],
        ),
      ),
    ));
  }
}
