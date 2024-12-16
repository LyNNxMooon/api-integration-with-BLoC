// ignore_for_file: deprecated_member_use, avoid_print

import 'package:bloc_api/BLoC/auth/auth_bloc.dart';
import 'package:bloc_api/BLoC/auth/auth_events.dart';
import 'package:bloc_api/BLoC/cart/cart_bloc.dart';
import 'package:bloc_api/BLoC/cart/cart_events.dart';
import 'package:bloc_api/BLoC/cart/cart_states.dart';
import 'package:bloc_api/BLoC/products/product_bloc.dart';
import 'package:bloc_api/BLoC/products/product_events.dart';
import 'package:bloc_api/BLoC/products/product_states.dart';
import 'package:bloc_api/constants/colors.dart';
import 'package:bloc_api/data/vos/item_vo.dart';
import 'package:bloc_api/screens/cart_screen.dart';
import 'package:bloc_api/utils/navigation_extension.dart';
import 'package:bloc_api/widgets/error_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final productsBloc = context.read<ProductsBloc>();
  late final authBloc = context.read<AuthBloc>();
  late final cartBloc = context.read<CartBloc>();

  @override
  void initState() {
    cartBloc.add(GetCart());
    print("---Cart Loaded----");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        backgroundColor: kThirdColor,
        leading: IconButton(
            color: kPrimaryColor,
            onPressed: () => authBloc.add(LogoutEvent()),
            icon: Icon(Icons.logout_rounded)),
        centerTitle: true,
        title: Text(
          authBloc.currentUser?.name ?? "",
          style: TextStyle(color: kPrimaryColor),
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 5),
            width: 42,
            height: 45,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: IconButton(
                      onPressed: () => context.navigateToNext(CartScreen()),
                      icon: Icon(
                        Icons.shopping_cart,
                        color: kPrimaryColor,
                      )),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: BlocBuilder<CartBloc, CartStates>(
                    builder: (context, state) {
                      if (state is CartLoaded && state.cart.data.isNotEmpty) {
                        return Container(
                          decoration: BoxDecoration(
                              color: kFourthColor,
                              borderRadius: BorderRadius.circular(10)),
                          width: 17,
                          height: 17,
                          child: Center(
                            child: Text(
                              state.cart.data.length.toString(),
                              style:
                                  TextStyle(color: kPrimaryColor, fontSize: 10),
                            ),
                          ),
                        );
                      } else {
                        return SizedBox();
                      }
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      body: BlocBuilder<ProductsBloc, ProductsStates>(
        builder: (context, state) {
          if (state is ProductsLoading) {
            return shimmerLoading();
          } else if (state is ProductsError) {
            return ErrorUIWidget(
              function: () => productsBloc.add(FetchProducts()),
              message: state.message,
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

  Widget shimmerLoading() {
    return ListView.separated(
        itemBuilder: (context, index) => Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Shimmer.fromColors(
                baseColor: Colors.black54,
                highlightColor: Colors.white,
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 70,
                      decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(5)),
                    ),
                    const Gap(15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.65,
                          height: 15,
                          decoration: BoxDecoration(
                              color: Colors.black12,
                              borderRadius: BorderRadius.circular(5)),
                        ),
                        const Gap(10),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.25,
                          height: 15,
                          decoration: BoxDecoration(
                              color: Colors.black12,
                              borderRadius: BorderRadius.circular(5)),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
        separatorBuilder: (context, index) => const Gap(15),
        itemCount: 10);
  }

  Widget productList(List<ItemVO> products, BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        productsBloc.add(FetchProducts());
      },
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
                child: CachedNetworkImage(
                  imageUrl: products[index].image,
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) => Icon(
                    Icons.error,
                    color: kFourthColor,
                  ),
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(
                      color: kSecondaryColor,
                    ),
                  ),
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
