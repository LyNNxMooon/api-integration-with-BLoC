import 'package:bloc_api/constants/colors.dart';

import 'package:flutter/material.dart';

class CustomLoadingWidget extends StatelessWidget {
  const CustomLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
        child: Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          strokeWidth: 1,
          color: kSecondaryColor,
        ),
      ),
    ));
  }
}
