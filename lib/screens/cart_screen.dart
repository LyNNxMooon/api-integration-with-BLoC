import 'package:bloc_api/constants/colors.dart';
import 'package:bloc_api/utils/navigation_extension.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        backgroundColor: kThirdColor,
        centerTitle: true,
        leading: IconButton(
            onPressed: () => context.navigateBack(),
            icon: Icon(
              Icons.arrow_back,
              color: kPrimaryColor,
            )),
        title: Text(
          "Your Cart",
          style: TextStyle(color: kPrimaryColor),
        ),
      ),
    ));
  }
}
