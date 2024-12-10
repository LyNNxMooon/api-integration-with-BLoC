// ignore_for_file: deprecated_member_use

import 'package:bloc_api/BLoC/cubits/auth/auth_cubit.dart';
import 'package:bloc_api/BLoC/cubits/products/product_cubit.dart';
import 'package:bloc_api/BLoC/cubits/products/product_states.dart';
import 'package:bloc_api/constants/colors.dart';
import 'package:bloc_api/data/vos/item_vo.dart';
import 'package:bloc_api/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();

    return SafeArea(
        child: Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        backgroundColor: kThirdColor,
        centerTitle: true,
        title: Column(
          children: [
            Text(
              authCubit.currentUser?.name ?? "",
              style: TextStyle(color: kPrimaryColor),
            )
          ],
        ),
        actions: [
          IconButton(
              color: kPrimaryColor,
              onPressed: () => authCubit.logoutUser(context),
              icon: Icon(Icons.logout_rounded))
        ],
      ),
      body: BlocBuilder<ProductsCubit, ProductsStates>(
        builder: (context, state) {
          if (state is ProductsLoading) {
            return const CustomLoadingWidget();
          } else if (state is ProductsError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  state.message,
                  style: TextStyle(
                      color: kErrorColor, fontWeight: FontWeight.bold),
                ),
              ),
            );
          } else if (state is ProductsLoaded) {
            return state.products.isEmpty
                ? const Center(
                    child: Text(
                      "No more products...",
                      style: TextStyle(color: kFourthColor),
                    ),
                  )
                : productList(state.products, context);
          } else {
            return SizedBox();
          }
        },
      ),
    ));
  }

  Widget productList(List<ItemVO> products, BuildContext context) {
    final productsCubit = context.read<ProductsCubit>();
    return RefreshIndicator(
      onRefresh: () => productsCubit.getAllProducts(),
      backgroundColor: kPrimaryColor,
      color: kSecondaryColor,
      child: ListView.separated(
        itemBuilder: (context, index) => Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1), // Shadow color
                spreadRadius: 3, // Spread radius
                blurRadius: 5, // Blur radius
                offset: const Offset(0, 3), // Offset of the shadow
              ),
            ], //border corner radius
          ),
          child: Row(
            children: [
              SizedBox(
                width: 40,
                height: 60,
                child: Image.network(
                  products[index].image,
                  fit: BoxFit.cover,
                  // loadingBuilder: (context, child, loadingProgress) => Center(
                  //   child: CircularProgressIndicator(
                  //     color: kSecondaryColor,
                  //   ),
                  // ),
                  // errorBuilder: (context, error, stackTrace) => SizedBox(),
                ),
              ),
              const Gap(20),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.65,
                child: Text(
                  products[index].name,
                  style: TextStyle(color: kFourthColor),
                ),
              ),
            ],
          ),
        ),
        itemCount: products.length,
        separatorBuilder: (context, index) => const Gap(15),
      ),
    );
  }
}
