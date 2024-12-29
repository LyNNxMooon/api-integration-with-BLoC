import 'package:bloc_api/constants/colors.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

class CustomLoadingWidget extends StatelessWidget {
  const CustomLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
        child: Scaffold(
      body: Center(
        child: CupertinoActivityIndicator(
          animating: true,
          radius: 10,
          color: kSecondaryColor,
        ),
      ),
    ));
  }
}

class ImageLoadingWidget extends StatelessWidget {
  const ImageLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CupertinoActivityIndicator(
        animating: true,
        color: kSecondaryColor,
      ),
    );
  }
}
