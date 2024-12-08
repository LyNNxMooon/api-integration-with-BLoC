import 'package:bloc_api/BLoC/cubits/auth/auth_cubit.dart';
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
    final authCubit = context.read<AuthCubit>();
    return SafeArea(
        child: Scaffold(
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
                "Modern Cashier POS",
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
                          color: kSecondaryColor,
                        )
                      : const Icon(
                          Icons.visibility_off_outlined,
                          color: kSecondaryColor,
                        )),
            ),
            const Gap(40),
            CustomButton(
              name: "Login",
              function: () => authCubit.loginUser(
                  _emailOrPhoneController.text, _passwordController.text),
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
                    style: TextStyle(fontSize: 12),
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
