import 'package:bloc_api/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ErrorUIWidget extends StatelessWidget {
  const ErrorUIWidget({super.key, this.function, required this.message});

  final void Function()? function;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              textAlign: TextAlign.center,
              message,
              style: TextStyle(color: kErrorColor, fontWeight: FontWeight.bold),
            ),
            const Gap(5),
            IconButton(
                onPressed: function,
                icon: Icon(
                  Icons.replay_outlined,
                  color: kThirdColor,
                ))
          ],
        ),
      ),
    );
  }
}
