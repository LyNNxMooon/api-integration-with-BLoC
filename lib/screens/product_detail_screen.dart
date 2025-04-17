// ignore_for_file: deprecated_member_use

import 'package:bloc_api/BLoC/cart/cart_bloc.dart';
import 'package:bloc_api/BLoC/cart/cart_events.dart';
import 'package:bloc_api/BLoC/cart/cart_states.dart';
import 'package:bloc_api/BLoC/product_details/product_detail_bloc.dart';
import 'package:bloc_api/BLoC/product_details/product_detail_events.dart';
import 'package:bloc_api/BLoC/product_details/product_details_states.dart';
import 'package:bloc_api/BLoC/product_images/product_images_bloc.dart';
import 'package:bloc_api/BLoC/product_images/product_images_states.dart';

import 'package:bloc_api/constants/colors.dart';
import 'package:bloc_api/constants/texts.dart';
import 'package:bloc_api/data/vos/item_vo.dart';
import 'package:bloc_api/screens/cart_screen.dart';
import 'package:bloc_api/utils/navigation_extension.dart';

import 'package:bloc_api/widgets/error_widget.dart';
import 'package:bloc_api/widgets/loading_widget.dart';
//import 'package:bloc_api/widgets/success_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key, required this.productID});

  final int productID;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  late final productDetailBloc = context.read<ProductDetailBloc>();
  late final productImageBloc = context.read<ProductImagesBloc>();

  late final cartBloc = context.read<CartBloc>();
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
              color: kPrimaryColor, fontSize: 15, fontWeight: FontWeight.bold),
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
        ],
      ),
      body: BlocBuilder<ProductDetailBloc, ProductDetailStates>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return CustomLoadingWidget();
          } else if (state is ProductError) {
            return ErrorUIWidget(
              message: state.message,
              function: () => productDetailBloc
                  .add(FetchProductDetail(productID: widget.productID)),
            );
          } else if (state is ProductLoaded) {
            return productDetailUI(state.product);
          } else if (state is UpdateQtyError) {
            return productDetailUI(state.product);
          } else if (state is UpdateQtySuccess) {
            return productDetailUI(state.product);
          } else {
            return SizedBox();
          }
        },
      ),
    ));
  }

  int _currentIndex = 0;

  Widget productDetailUI(ItemVO product) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          Gap(20),
          //Carousal Slider
          BlocBuilder<ProductImagesBloc, ProductImagesStates>(
            builder: (context, state) {
              if (state is ProductImagesLoaded) {
                return Column(
                  children: [
                    //Product Image Slider
                    CarouselSlider.builder(
                        itemCount: state.productImages.length,
                        itemBuilder: (context, index, realIndex) => Container(
                              width: MediaQuery.of(context).size.width / 0.75,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.black12),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: CachedNetworkImage(
                                    imageUrl: state.productImages[index].image,
                                    fit: BoxFit.fill,
                                    placeholder: (context, url) =>
                                        ImageLoadingWidget(),
                                    errorWidget: (context, url, error) => Icon(
                                      Icons.error,
                                      color: kFourthColor,
                                    ),
                                  )),
                            ),
                        options: CarouselOptions(
                          autoPlay: false,
                          aspectRatio: 1.5 / 1,
                          viewportFraction: 0.75,
                          initialPage: 0,
                          enableInfiniteScroll: false,
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: true,
                          enlargeFactor: 0.55,
                          scrollDirection: Axis.horizontal,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _currentIndex = index;
                            });
                          },
                        )),
                    const Gap(10),
                    //Slider Indicator
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:
                          state.productImages.asMap().entries.map((entry) {
                        return Container(
                          width: 8.0,
                          height: 8.0,
                          margin: const EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 4.0,
                          ),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _currentIndex == entry.key
                                ? kThirdColor
                                : Colors.grey,
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                );
              } else {
                return SizedBox();
              }
            },
          ),
          Gap(30),
          //Product Details Info
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 220,
                      child: Text(
                        product.name,
                        style: subtitleStyle,
                      ),
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.favorite_border_outlined,
                          color: kThirdColor,
                        ))
                  ],
                ),
                const Gap(10),
                Text(
                  "${product.price} Ks",
                  style: titleStyle,
                ),
                const Gap(15),
                Text(
                  "Description",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const Gap(10),
                Text(product.description!),
                const Gap(30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      width: 120,
                      height: 40,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color:
                                Colors.black.withOpacity(0.1), // Shadow color
                            spreadRadius: 3, // Spread radius
                            blurRadius: 5, // Blur radius
                            offset: const Offset(0, 3), // Offset of the shadow
                          ),
                        ], //bo
                        color: kThirdColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () => productDetailBloc
                                .add(DecreaseQty(product: product)),
                            child: Container(
                              width: 25,
                              height: 25,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: kSecondaryColor),
                              child: Icon(
                                Icons.remove,
                                size: 16,
                                color: kPrimaryColor,
                              ),
                            ),
                          ),
                          BlocConsumer<ProductDetailBloc, ProductDetailStates>(
                            builder: (context, state) {
                              if (state is UpdateQtySuccess) {
                                return Text(
                                  state.updatedQty.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: kPrimaryColor),
                                );
                              } else if (state is UpdateQtyError) {
                                return Text(
                                  state.qty.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: kPrimaryColor),
                                );
                              } else {
                                return Text(
                                  productDetailBloc.productQty.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: kPrimaryColor),
                                );
                              }
                            },
                            listener: (context, state) {
                              if (state is UpdateQtyError) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(state.message),
                                    backgroundColor: kErrorColor,
                                  ),
                                );
                              }
                            },
                          ),
                          InkWell(
                            onTap: () => productDetailBloc
                                .add(IncreaseQty(product: product)),
                            child: Container(
                              width: 25,
                              height: 25,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: kSecondaryColor),
                              child: Icon(
                                Icons.add,
                                size: 16,
                                color: kPrimaryColor,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        cartBloc.add(AddToCart(
                            productID: product.id,
                            qty: productDetailBloc.productQty));
                      },
                      child: Container(
                        width: 120,
                        height: 40,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black
                                  .withOpacity(0.1), // Shadow color
                              spreadRadius: 3, // Spread radius
                              blurRadius: 5, // Blur radius
                              offset:
                                  const Offset(0, 3), // Offset of the shadow
                            ),
                          ], //bo
                          color: kThirdColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Add",
                              style: TextStyle(
                                  color: kPrimaryColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            const Gap(10),
                            Icon(
                              Icons.add_shopping_cart_sharp,
                              size: 18,
                              color: kPrimaryColor,
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                const Gap(40)
              ],
            ),
          )
        ],
      ),
    );
  }
}
