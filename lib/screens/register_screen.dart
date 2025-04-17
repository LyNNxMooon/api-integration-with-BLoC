import 'package:bloc_api/BLoC/auth/auth_bloc.dart';
import 'package:bloc_api/BLoC/auth/auth_events.dart';
import 'package:bloc_api/constants/texts.dart';
import 'package:bloc_api/utils/enums.dart';
import 'package:bloc_api/widgets/button_widget.dart';
import 'package:bloc_api/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../constants/colors.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key, required this.toggleScreens});

  final void Function()? toggleScreens;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool showPassword = true;
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
              Gap(MediaQuery.of(context).size.height * 0.1),
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
                  "Register to start",
                  style: subtitleStyle,
                ),
              ),
              const Gap(40),
              CustomTextField(
                hintText: "Enter your Name",
                label: "Name",
                controller: _nameController,
              ),
              const Gap(20),
              CustomTextField(
                validator: Validator.phone,
                keyboardType: TextInputType.number,
                hintText: "Enter your Phone",
                label: "Phone",
                controller: _phoneController,
              ),
              const Gap(20),
              CustomTextField(
                controller: _passwordController,
                hintText: "Enter your Password",
                label: "Password",
                isObscure: showPassword,
                validator: Validator.password,
                suffixIcon: IconButton(
                    onPressed: () {
                      showPassword = !showPassword;
                      setState(() {});
                    },
                    icon: showPassword
                        ? const Icon(
                            Icons.visibility_outlined,
                            color: kThirdColor,
                          )
                        : const Icon(
                            Icons.visibility_off_outlined,
                            color: kThirdColor,
                          )),
              ),
              const Gap(20),
              CustomTextField(
                controller: _confirmPasswordController,
                hintText: "Confirm your Password",
                label: "Confirm Password",
                isObscure: showPassword,
                suffixIcon: IconButton(
                    onPressed: () {
                      showPassword = !showPassword;
                      setState(() {});
                    },
                    icon: showPassword
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
                name: "Register",
                function: () => authBloc.add(RegisterEvent(
                    name: _nameController.text,
                    phone: _phoneController.text,
                    password: _passwordController.text,
                    confirmPassword: _confirmPasswordController.text)),
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
                      "Already have account? Login",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: kThirdColor),
                    ))
                  ],
                ),
              ),
              const Gap(60),
            ],
          ),
        ),
      ),
    );
  }
}
