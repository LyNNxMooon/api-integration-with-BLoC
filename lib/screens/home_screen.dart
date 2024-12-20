// ignore_for_file: deprecated_member_use, avoid_print, prefer_final_fields

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
import 'package:bloc_api/widgets/error_dialog.dart';
import 'package:bloc_api/widgets/error_widget.dart';
import 'package:bloc_api/widgets/success_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
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
          style: TextStyle(
              color: kPrimaryColor, fontSize: 18, fontWeight: FontWeight.bold),
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
                      if (state is CartLoading) {
                        return Container(
                          padding: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                              color: kFourthColor,
                              borderRadius: BorderRadius.circular(10)),
                          width: 17,
                          height: 17,
                          child: Center(
                              child: CircularProgressIndicator(
                            strokeWidth: 0.8,
                            color: kPrimaryColor,
                          )),
                        );
                      }

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
                              style: TextStyle(
                                  color: kPrimaryColor,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold),
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
            return state.products.data.isEmpty
                ? const Center(
                    child: Text(
                      "No more products...",
                      style: TextStyle(color: kFourthColor),
                    ),
                  )
                : productsUI(state.products.data, state.products.total);
          } else {
            return SizedBox();
          }
        },
      ),
    ));
  }

  Widget shimmerLoading() {
    return ListView.separated(
        padding: EdgeInsets.symmetric(vertical: 20),
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

  Widget pageSelectionItemList(int totalProduct) {
    return SizedBox(
      height: 45,
      child: ListView.separated(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 30, right: 30, bottom: 15),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  productsBloc.page = index + 1;
                  productsBloc.add(FetchProducts());
                },
                child: Container(
                  width: 25,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: kFourthColor),
                    color: productsBloc.page == index + 1
                        ? kFourthColor
                        : kPrimaryColor,
                  ),
                  child: Center(
                    child: Text(
                      (index + 1).toString(),
                      style: TextStyle(
                          color: productsBloc.page == index + 1
                              ? kPrimaryColor
                              : kFourthColor),
                    ),
                  ),
                ),
              ),
          separatorBuilder: (context, index) => const Gap(25),
          itemCount: (totalProduct / 10).ceil()),
    );
  }

  Widget productCard(ItemVO product, int index) {
    return GestureDetector(
      onTap: () {},
      child: Container(
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
              width: 45,
              height: 70,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: CachedNetworkImage(
                  imageUrl: product.image,
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
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: TextStyle(
                        color: kFourthColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.5),
                  ),
                  const Gap(5),
                  Text(
                    "${product.price} Ks",
                    style: TextStyle(
                        color: kSecondaryColor, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            IconButton(
                onPressed: () {
                  cartBloc.add(AddToCart(productID: index + 1, qty: 1));
                },
                icon: Icon(
                  Icons.add_shopping_cart_sharp,
                  color: kSecondaryColor,
                ))
          ],
        ),
      ),
    );
  }

  Widget productList(List<ItemVO> products) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(vertical: 10),
      shrinkWrap: true,
      itemBuilder: (context, index) => productCard(products[index], index),
      itemCount: products.length,
      separatorBuilder: (context, index) => const Gap(15),
    );
  }

  Widget productsUI(List<ItemVO> products, int totalProduct) {
    return BlocConsumer<CartBloc, CartStates>(
      builder: (context, state) => RefreshIndicator(
        onRefresh: () async {
          productsBloc.add(FetchProducts());
        },
        backgroundColor: kPrimaryColor,
        color: kSecondaryColor,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              slider(),
              pageSelectionItemList(totalProduct),
              productList(products)
            ],
          ),
        ),
      ),
      listener: (context, state) {
        if (state is CartErrors) {
          showDialog(
            context: context,
            builder: (context) => CustomErrorWidget(
              errorMessage: state.message,
              function: () => context.navigateBack(),
            ),
          );
        }

        if (state is CartAdded && state.addedResponse.status == "error") {
          showDialog(
            context: context,
            builder: (context) => CustomErrorWidget(
              errorMessage: state.addedResponse.data,
              function: () => context.navigateBack(),
            ),
          );
        }

        if (state is CartAdded && state.addedResponse.status == "success") {
          showDialog(
            context: context,
            builder: (context) =>
                SuccessWidget(message: state.addedResponse.data),
          );
        }
      },
    );
  }

  Widget slider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: CarouselSlider.builder(
          itemCount: 3,
          itemBuilder: (context, index, realIndex) => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    "assets/images/banner.jpg",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
          options: CarouselOptions(
            autoPlay: true,
            aspectRatio: 2.5 / 1,
            viewportFraction: 0.7,
            initialPage: 0,
            enableInfiniteScroll: true,
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            enlargeFactor: 0.3,
            scrollDirection: Axis.horizontal,
          )),
    );
  }
}
