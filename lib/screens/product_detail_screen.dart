import 'package:bloc_api/BLoC/product_details/product_detail_bloc.dart';
import 'package:bloc_api/BLoC/product_details/product_details_states.dart';
import 'package:bloc_api/constants/colors.dart';
import 'package:bloc_api/utils/navigation_extension.dart';
import 'package:bloc_api/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
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
          "Product Details",
          style: TextStyle(
              color: kPrimaryColor, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocBuilder<ProductDetailBloc, ProductDetailStates>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return CustomLoadingWidget();
          } else {
            return SizedBox();
          }
        },
      ),
    ));
  }
}
