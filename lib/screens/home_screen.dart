// ignore_for_file: deprecated_member_use, avoid_print, prefer_final_fields

import 'package:bloc_api/BLoC/auth/auth_bloc.dart';

import 'package:bloc_api/BLoC/banner/banner_bloc.dart';
import 'package:bloc_api/BLoC/banner/banner_events.dart';
import 'package:bloc_api/BLoC/banner/banner_states.dart';
import 'package:bloc_api/BLoC/cart/cart_bloc.dart';
import 'package:bloc_api/BLoC/cart/cart_events.dart';
import 'package:bloc_api/BLoC/cart/cart_states.dart';
import 'package:bloc_api/BLoC/general/general_bloc.dart';
import 'package:bloc_api/BLoC/general/general_events.dart';
import 'package:bloc_api/BLoC/general/general_states.dart';
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
import 'package:bloc_api/screens/profile_screen.dart';
import 'package:bloc_api/utils/navigation_extension.dart';

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
  late final genereBloc = context.read<GenereBloc>();

  @override
  void initState() {
    cartBloc.add(GetCart());
    super.initState();
  }

  int index = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color.fromARGB(255, 245, 248, 255),
      appBar: AppBar(
        elevation: 5,
        backgroundColor: kThirdColor,
        title: Text(
          //authBloc.currentUser?.name ?? "",
          "One One BookShop",
          style: TextStyle(
              color: kPrimaryColor, fontSize: 15, fontWeight: FontWeight.w500),
        ),
        actions: [
          Row(
            children: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.category_outlined,
                    color: kPrimaryColor,
                  )),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.history,
                    color: kPrimaryColor,
                  )),
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
                                  color: kSecondaryColor,
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

                          if (state is CartLoaded && state.cart.isNotEmpty) {
                            return Container(
                              decoration: BoxDecoration(
                                  color: kSecondaryColor,
                                  borderRadius: BorderRadius.circular(10)),
                              width: 17,
                              height: 17,
                              child: Center(
                                child: Text(
                                  state.cart.length.toString(),
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
              ),
              GestureDetector(
                onTap: () => context.navigateToNext(ProfileScreen()),
                child: Container(
                  width: 30,
                  margin: EdgeInsets.all(12.5),
                  decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(8)),
                  child: Center(
                      child: Text(
                    authBloc.currentUser?.name.substring(0, 1) ?? " - ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: kThirdColor,
                        fontSize: 16.5),
                  )),
                ),
              ),
            ],
          )
        ],
      ),
      body: homeUI(),
    ));
  }

  Widget generesShimmerLoading() {
    return SizedBox(
      height: 95,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => Shimmer.fromColors(
              baseColor: Colors.black54,
                highlightColor: Colors.white,
            child: SizedBox(
              child: Column(
                children: [
                  Shimmer.fromColors(
                      baseColor: Colors.black54,
                    highlightColor: Colors.white,
                    child: Container(
                      width: 65,
                      height: 65,
                      decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  const Gap(10),
                  Shimmer.fromColors(
                      baseColor: Colors.black54,
                    highlightColor: Colors.white,
                    child: Container(
                      width: 65,
                      height: 12,
                      decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          separatorBuilder: (context, index) => const Gap(10),
          itemCount: 10),
    );
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
                  productsBloc
                      .add(FetchProducts(status: index == 0 ? "" : "new"));
                },
                child: Container(
                  width: 25,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: kThirdColor),
                    color: productsBloc.page == index + 1
                        ? kThirdColor
                        : Colors.white,
                  ),
                  child: Center(
                    child: Text(
                      (index + 1).toString(),
                      style: TextStyle(
                          color: productsBloc.page == index + 1
                              ? Colors.white
                              : kThirdColor),
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
        productDetailBloc.productQty = 1;
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
          // border: Border.all(width: 0.15),
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
            Row(
              children: [
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(5)),
                  width: MediaQuery.of(context).size.width * 0.12,
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
                Container(
                  margin: EdgeInsets.only(left: 10),
                  width: MediaQuery.of(context).size.width * 0.48,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        softWrap: true,
                        product.name,
                        style: TextStyle(
                            color: kSecondaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 13),
                      ),
                      const Gap(5),
                      Text(
                        "${product.price} Ks",
                        style: TextStyle(
                            fontSize: 12,
                            color: kThirdColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            IconButton(
                onPressed: () {
                  cartBloc.add(AddToCart(productID: product.id, qty: 1));
                },
                icon: Icon(
                  Icons.add_shopping_cart_sharp,
                  color: kThirdColor,
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
          productsBloc.add(FetchProducts(status: index == 0 ? "" : "new"));
          bannerBloc.add(FetchBanners());
        },
        backgroundColor: kPrimaryColor,
        color: kSecondaryColor,
        child: SingleChildScrollView(
          physics: RangeMaintainingScrollPhysics(),
          child: Column(
            children: [
              const Gap(20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Generes",
                          style: TextStyle(
                              color: kThirdColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                        const Gap(10),
                        GestureDetector(
                            onTap: () {
                              genereBloc.add(FetchGeneresEvent());
                            },
                            child: Icon(
                              Icons.refresh,
                              size: 16,
                              color: kSecondaryColor,
                            ))
                      ],
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        "View All",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(20),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: BlocBuilder<GenereBloc, GenereStates>(
                    builder: (context, state) {
                      if (state is GenereInit) {
                        return generesShimmerLoading();
                      } else if (state is GenereLoading) {
                        return generesShimmerLoading();
                      } else if (state is GenereError) {
                        return SizedBox(
                        height: 95,
                          width: 200,
                          child: Center(
                            child: Text(
                              state.message,
                              style: TextStyle(
                                  color: kErrorColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        );
                      } else if (state is GenereLoaded) {
                        return SizedBox(
                          height: 95,
                          child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) => Column(
                                    children: [
                                      Container(
                                        width: 65,
                                        height: 65,
                                        decoration: BoxDecoration(
                                            //color: Colors.black12,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: CachedNetworkImage(
                                              imageUrl:
                                                  state.generes[index].image,
                                              fit: BoxFit.cover,
                                              errorWidget:
                                                  (context, url, error) => Icon(
                                                        Icons.error,
                                                        color: kFourthColor,
                                                      ),
                                              placeholder: (context, url) =>
                                                  ImageLoadingWidget()),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 60,
                                        child: Text(
                                          state.generes[index].name.length > 14 ? "${state.generes[index].name.substring(0,14)}..." : state.generes[index].name,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 10),
                                        ),
                                      )
                                    ],
                                  ),
                              separatorBuilder: (context, index) =>
                                  const Gap(10),
                              itemCount: state.generes.length),
                        );
                     
                      } else {
                        return SizedBox(
                          height: 70,
                        );
                      }
                    },
                  )),
                  const Gap(5),
                  const Padding(padding: EdgeInsets.symmetric(horizontal: 20), child: Divider(thickness: 0.7,),),
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
                                    MediaQuery.of(context).size.height * 0.121),
                            child: Text(
                              "No banner available...",
                              style: TextStyle(color: kFourthColor),
                            ),
                          )
                        : slider(state.banners);
                  } else if (state is BannersInitial) {
                    return bannerShimmerLoading();
                  } else {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.221,
                    );
                  }
                },
              ),
              Container(
                padding: EdgeInsets.only(bottom: 20),
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
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                child: Column(
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            productsBloc.add(FetchProducts(status: ""));
                            setState(() {
                              index = 0;
                            });
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            height: 40,
                            decoration: BoxDecoration(
                                color: index == 0 ? kThirdColor : kPrimaryColor,
                                border: index == 0
                                    ? Border.all(
                                        width: 1.5,
                                        color: kThirdColor,
                                      )
                                    : Border(
                                        bottom: BorderSide(
                                            width: 1.5, color: kThirdColor),
                                      ),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(29))),
                            child: Center(
                              child: Text(
                                "All",
                                style: TextStyle(
                                    color: index == 0
                                        ? kPrimaryColor
                                        : kThirdColor,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            productsBloc.add(FetchProducts(status: "new"));
                            setState(() {
                              index = 1;
                            });
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.5 - 2,
                            height: 40,
                            decoration: BoxDecoration(
                                color: index == 1 ? kThirdColor : kPrimaryColor,
                                border: index == 1
                                    ? Border.all(
                                        width: 1.5,
                                        color: kThirdColor,
                                      )
                                    : Border(
                                        bottom: BorderSide(
                                            width: 1.5, color: kThirdColor),
                                      ),
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(29))),
                            child: Center(
                              child: Text(
                                "New",
                                style: TextStyle(
                                    color: index == 0
                                        ? kThirdColor
                                        : kPrimaryColor,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    const Gap(25),
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
                                  productsBloc.add(FetchProducts(status: ""));
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
                        } else if (state is ProductsInitial) {
                          return productsShimmerLoading();
                        } else {
                          return SizedBox(
                            height: MediaQuery.of(context).size.height * 0.6,
                          );
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

        if (state is CartAdded) {
          showDialog(
            context: context,
            builder: (context) => SuccessWidget(message: "Added to Carts"),
          );
        }
      },
    );
  }

  Widget bannerShimmerLoading() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35, top: 22),
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
      padding: const EdgeInsets.only(top: 22, bottom: 35),
      child: CarouselSlider.builder(
          itemCount: banners.length,
          itemBuilder: (context, index, realIndex) => Container(
                width: MediaQuery.of(context).size.width / 0.6,
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
            viewportFraction: 0.75,
            initialPage: 0,
            enableInfiniteScroll: true,
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            enlargeFactor: 0.4,
            scrollDirection: Axis.horizontal,
          )),
    );
  }
}
