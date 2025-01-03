import 'package:bloc_api/BLoC/product_details/product_detail_bloc.dart';
import 'package:bloc_api/BLoC/product_details/product_detail_events.dart';
import 'package:bloc_api/BLoC/product_details/product_details_states.dart';
import 'package:bloc_api/BLoC/product_images/product_images_bloc.dart';
import 'package:bloc_api/BLoC/product_images/product_images_states.dart';

import 'package:bloc_api/constants/colors.dart';
import 'package:bloc_api/constants/texts.dart';
import 'package:bloc_api/data/vos/item_vo.dart';
import 'package:bloc_api/utils/navigation_extension.dart';

import 'package:bloc_api/widgets/error_widget.dart';
import 'package:bloc_api/widgets/loading_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_options.dart';
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
          } else if (state is ProductError) {
            return ErrorUIWidget(
              message: state.message,
              function: () => productDetailBloc
                  .add(FetchProductDetail(productID: widget.productID)),
            );
          } else if (state is ProductLoaded) {
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
          BlocBuilder<ProductImagesBloc, ProductImagesStates>(
            builder: (context, state) {
              if (state is ProductImagesLoaded) {
                return Column(
                  children: [
                    CarouselSlider.builder(
                        itemCount: state.productImages.length,
                        itemBuilder: (context, index, realIndex) => Container(
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
                          viewportFraction: 0.8,
                          initialPage: 0,
                          enableInfiniteScroll: false,
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: true,
                          enlargeFactor: 0,
                          scrollDirection: Axis.horizontal,
                        )),
                    const Gap(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:
                          state.productImages.asMap().entries.map((entry) {
                        return GestureDetector(
                          onTap: () => setState(() {
                            _currentIndex = entry.key;
                          }),
                          child: Container(
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      product.name,
                      style: subtitleStyle,
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.favorite_border_outlined,
                          color: kFourthColor,
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
                const Gap(20)
              ],
            ),
          )
        ],
      ),
    );
  }
}
