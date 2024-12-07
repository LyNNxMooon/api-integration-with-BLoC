import 'package:bloc_api/constants/colors.dart';
import 'package:bloc_api/utils/navigation_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SuccessWidget extends StatelessWidget {
  const SuccessWidget({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        actions: [
          Center(
            child: TextButton(
              onPressed: () {
                context.navigateBack();
              },
              style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(kSecondaryColor)),
              child: const Text(
                "OK",
                style: TextStyle(color: kPrimaryColor),
              ),
            ),
          )
        ],
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.check_circle,
              color: kSuccessColor,
            ),
            const Gap(15),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(color: kFourthColor),
            ),
          ],
        ));
  }
}
