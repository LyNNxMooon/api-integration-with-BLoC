// ignore_for_file: deprecated_member_use, avoid_print, prefer_final_fields

import 'package:bloc_api/BLoC/auth/auth_bloc.dart';
import 'package:bloc_api/BLoC/auth/auth_events.dart';
import 'package:bloc_api/BLoC/banner/banner_bloc.dart';
import 'package:bloc_api/BLoC/banner/banner_events.dart';
import 'package:bloc_api/BLoC/banner/banner_states.dart';
import 'package:bloc_api/BLoC/cart/cart_bloc.dart';
import 'package:bloc_api/BLoC/cart/cart_events.dart';
import 'package:bloc_api/BLoC/cart/cart_states.dart';
import 'package:bloc_api/BLoC/product_details/product_detail_bloc.dart';
import 'package:bloc_api/BLoC/product_details/product_detail_events.dart';
import 'package:bloc_api/BLoC/product_images/product_images_bloc.dart';
import 'package:bloc_api/BLoC/product_images/product_images_events.dart';
import 'package:bloc_api/BLoC/products/product_bloc.dart';
import 'package:bloc_api/BLoC/products/product_events.dart';
import 'package:bloc_api/BLoC/products/product_states.dart';
import 'package:bloc_api/constants/colors.dart';
import 'package:bloc_api/data/vos/banner_vo.dart';
import 'package:bloc_api/data/vos/item_vo.dart';
import 'package:bloc_api/screens/cart_screen.dart';
import 'package:bloc_api/screens/product_detail_screen.dart';
import 'package:bloc_api/utils/navigation_extension.dart';
import 'package:bloc_api/widgets/error_dialog.dart';
import 'package:bloc_api/widgets/error_widget.dart';
import 'package:bloc_api/widgets/loading_widget.dart';
import 'package:bloc_api/widgets/no_internet_animation.dart';
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
  late final bannerBloc = context.read<BannerBloc>();
  late final productDetailBloc = context.read<ProductDetailBloc>();
  late final productImagesBloc = context.read<ProductImagesBloc>();

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
      body: homeUI(),
    ));
  }

  Widget productsShimmerLoading() {
    return ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
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
                        : Colors.white,
                  ),
                  child: Center(
                    child: Text(
                      (index + 1).toString(),
                      style: TextStyle(
                          color: productsBloc.page == index + 1
                              ? Colors.white
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
      onTap: () {
        productDetailBloc.add(FetchProductDetail(productID: product.id));
        productImagesBloc.add(FetchProductImages(productID: product.id));
        context.navigateToNext(ProductDetailScreen(
          productID: product.id,
        ));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: kPrimaryColor,
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
                    placeholder: (context, url) => ImageLoadingWidget()),
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

  Widget homeUI() {
    return BlocConsumer<CartBloc, CartStates>(
      builder: (context, state) => RefreshIndicator(
        onRefresh: () async {
          productsBloc.add(FetchProducts());
          bannerBloc.add(FetchBanners());
        },
        backgroundColor: kPrimaryColor,
        color: kSecondaryColor,
        child: SingleChildScrollView(
          physics: RangeMaintainingScrollPhysics(),
          child: Column(
            children: [
              BlocBuilder<BannerBloc, BannerStates>(
                builder: (context, state) {
                  if (state is BannersLoading) {
                    return bannerShimmerLoading();
                  } else if (state is BannersError) {
                    return Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.1,
                          bottom: MediaQuery.of(context).size.height * 0.075),
                      child: ErrorUIWidget(
                        function: () => bannerBloc.add(FetchBanners()),
                        message: state.message,
                      ),
                    );
                  } else if (state is BannersLoaded) {
                    return state.banners.isEmpty
                        ? Padding(
                            padding: EdgeInsets.symmetric(
                                vertical:
                                    MediaQuery.of(context).size.height * 0.12),
                            child: Text(
                              "No banner available...",
                              style: TextStyle(color: kFourthColor),
                            ),
                          )
                        : slider(state.banners);
                  } else {
                    return SizedBox();
                  }
                },
              ),
              Container(
                padding: EdgeInsets.only(top: 40, bottom: 20),
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.black12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1), // Shadow color
                        spreadRadius: 4, // Spread radius
                        blurRadius: 5, // Blur radius
                        offset: const Offset(0, 0), // Offset of the shadow
                      ),
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40))),
                child: Column(
                  children: [
                    BlocBuilder<ProductsBloc, ProductsStates>(
                      builder: (context, state) {
                        if (state is ProductsLoaded &&
                            state.products.data.isNotEmpty) {
                          return pageSelectionItemList(state.products.total);
                        } else {
                          return SizedBox(
                            height: 45,
                          );
                        }
                      },
                    ),
                    BlocBuilder<ProductsBloc, ProductsStates>(
                      builder: (context, state) {
                        if (state is ProductsLoading) {
                          return productsShimmerLoading();
                        } else if (state is ProductsError) {
                          return Padding(
                              padding: EdgeInsets.only(
                                  top:
                                      MediaQuery.of(context).size.height * 0.12,
                                  bottom: MediaQuery.of(context).size.height *
                                      0.24),
                              child: NoInternetAnimationWidget(
                                function: () {
                                  productsBloc.add(FetchProducts());
                                },
                              ));
                        } else if (state is ProductsLoaded) {
                          return state.products.data.isEmpty
                              ? Padding(
                                  padding: EdgeInsets.only(
                                      top: MediaQuery.of(context).size.height *
                                          0.22),
                                  child: Text(
                                    "No more products...",
                                    style: TextStyle(color: kFourthColor),
                                  ),
                                )
                              : productList(state.products.data);
                        } else {
                          return SizedBox();
                        }
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      listener: (context, state) {
        if (state is CartErrors) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: kErrorColor,
            ),
          );
          // showDialog(
          //   context: context,
          //   builder: (context) => CustomErrorWidget(
          //     errorMessage: state.message,
          //     function: () {
          //       context.navigateBack();
          //     },
          //   ),
          // );
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

  Widget bannerShimmerLoading() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: CarouselSlider.builder(
          itemCount: 3,
          itemBuilder: (context, index, realIndex) => Shimmer.fromColors(
                baseColor: Colors.black54,
                highlightColor: Colors.white,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(20),
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

  Widget slider(List<BannerVO> banners) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: CarouselSlider.builder(
          itemCount: banners.length,
          itemBuilder: (context, index, realIndex) => Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.black12),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: CachedNetworkImage(
                      imageUrl: banners[index].image,
                      fit: BoxFit.fill,
                      placeholder: (context, url) => ImageLoadingWidget(),
                      errorWidget: (context, url, error) => Icon(
                        Icons.error,
                        color: kFourthColor,
                      ),
                    )),
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
