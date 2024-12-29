import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NoInternetAnimationWidget extends StatelessWidget {
  const NoInternetAnimationWidget({super.key, required this.function});

  final void Function()? function;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Center(
        child: SizedBox(
          height: 130,
          width: 130,
          child: Lottie.asset("assets/animations/no_internet.json",
              fit: BoxFit.fill),
        ),
      ),
    );
  }
}
