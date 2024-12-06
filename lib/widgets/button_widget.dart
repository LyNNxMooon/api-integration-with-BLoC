// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:bloc_api/constants/colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.name, required this.function});

  final String name;
  final VoidCallback function;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: kSecondaryColor,
          borderRadius: BorderRadius.all(Radius.circular(15)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1), // Shadow color
              spreadRadius: 3, // Spread radius
              blurRadius: 5, // Blur radius
              offset: const Offset(0, 3), // Offset of the shadow
            ),
          ],
        ),
        child: Center(
          child: Text(
            name,
            style: const TextStyle(
              color: kPrimaryColor,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
