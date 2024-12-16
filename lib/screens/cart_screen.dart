// ignore_for_file: deprecated_member_use

import 'package:bloc_api/BLoC/cart/cart_bloc.dart';
import 'package:bloc_api/BLoC/cart/cart_events.dart';
import 'package:bloc_api/BLoC/cart/cart_states.dart';
import 'package:bloc_api/constants/colors.dart';

import 'package:bloc_api/network/response/cart_response.dart';
import 'package:bloc_api/utils/navigation_extension.dart';
import 'package:bloc_api/widgets/button_widget.dart';
import 'package:bloc_api/widgets/error_dialog.dart';
import 'package:bloc_api/widgets/error_widget.dart';
import 'package:bloc_api/widgets/success_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:shimmer/shimmer.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
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
          "Your Cart",
          style: TextStyle(color: kPrimaryColor),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.delete_outline,
                color: kPrimaryColor,
              ))
        ],
      ),
      body: BlocConsumer<CartBloc, CartStates>(
        builder: (context, state) {
          if (state is CartLoading) {
            return shimmerLoading();
          } else if (state is CartErrors) {
            return ErrorUIWidget(
              message: state.message,
              function: () => cartBloc.add(GetCart()),
            );
          } else if (state is CartLoaded) {
            return state.cart.data.isEmpty ? emptyCartUI() : cartUI(state.cart);
          } else {
            return SizedBox();
          }
        },
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

          if (state is CartUpdated && state.updateResponse.status == "error") {
            showDialog(
              context: context,
              builder: (context) => CustomErrorWidget(
                errorMessage: state.updateResponse.data is Map
                    ? state.updateResponse.data['quantity'][0]
                    : state.updateResponse.data,
                function: () => context.navigateBack(),
              ),
            );
          }

          if (state is CartUpdated &&
              state.updateResponse.status == "success") {
            showDialog(
              context: context,
              builder: (context) =>
                  SuccessWidget(message: state.updateResponse.data),
            );
          }
        },
      ),
    ));
  }

  Widget emptyCartUI() {
    return RefreshIndicator(
      backgroundColor: kPrimaryColor,
      color: kSecondaryColor,
      onRefresh: () async {
        cartBloc.add(GetCart());
      },
      child: ListView(
        children: [
          Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.36),
            child: Icon(
              Icons.remove_shopping_cart_outlined,
              color: kFourthColor,
              size: 100,
            ),
          ),
        ],
      ),
    );
  }

  Widget shimmerLoading() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ListView.separated(
          itemBuilder: (context, index) => Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Shimmer.fromColors(
                  baseColor: Colors.black54,
                  highlightColor: Colors.white,
                  child: Container(
                    width: double.infinity,
                    height: 100,
                    decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
          separatorBuilder: (context, index) => const Gap(15),
          itemCount: 5),
    );
  }

  Widget cartUI(CartResponse cart) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: RefreshIndicator(
            backgroundColor: kPrimaryColor,
            color: kSecondaryColor,
            onRefresh: () async {
              cartBloc.add(GetCart());
            },
            child: ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) => Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      width: double.infinity,
                      height: 100,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color:
                                  Colors.black.withOpacity(0.1), // Shadow color
                              spreadRadius: 3, // Spread radius
                              blurRadius: 5, // Blur radius
                              offset:
                                  const Offset(0, 3), // Offset of the shadow
                            ),
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 18,
                            height: 18,
                            decoration: BoxDecoration(
                                color: kFourthColor,
                                borderRadius: BorderRadius.circular(20)),
                            child: Center(
                              child: Icon(
                                Icons.remove,
                                size: 14,
                                color: kSecondaryColor,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 55,
                            height: 75,
                            child: CachedNetworkImage(
                              imageUrl: cart.data[index].product.photos.isEmpty
                                  ? ""
                                  : cart.data[index].product.photos[0],
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
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.42,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  cart.data[index].product.name,
                                  style: TextStyle(
                                      fontSize: 16, color: kFourthColor),
                                ),
                                const Gap(5),
                                Text(
                                  "${cart.data[index].totalPrice.toString()} Ks",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: kFourthColor),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () => cartBloc.add(UpdateCart(
                                    cartID: cart.data[index].id,
                                    qty: cart.data[index].quantity + 1)),
                                child: Container(
                                  width: 18,
                                  height: 18,
                                  decoration: BoxDecoration(
                                      color: kFourthColor,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Center(
                                    child: Icon(
                                      Icons.add,
                                      size: 14,
                                      color: kSecondaryColor,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child:
                                    Text(cart.data[index].quantity.toString()),
                              ),
                              GestureDetector(
                                onTap: () => cartBloc.add(UpdateCart(
                                    cartID: cart.data[index].id,
                                    qty: cart.data[index].quantity - 1)),
                                child: Container(
                                  width: 18,
                                  height: 18,
                                  decoration: BoxDecoration(
                                      color: kFourthColor,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Center(
                                    child: Icon(
                                      Icons.remove,
                                      size: 14,
                                      color: kSecondaryColor,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                separatorBuilder: (context, index) => const Gap(15),
                itemCount: cart.data.length),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          height: 210,
          width: double.infinity,
          decoration: BoxDecoration(
              color: kThirdColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total Amount",
                    style: TextStyle(
                        color: kPrimaryColor, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${cart.totalPrice.toString()} Ks",
                    style: TextStyle(
                        color: kPrimaryColor, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              const Gap(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Tax",
                    style: TextStyle(
                        color: kPrimaryColor, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    cart.tax,
                    style: TextStyle(
                        color: kPrimaryColor, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              const Gap(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Tax Amount",
                    style: TextStyle(
                        color: kPrimaryColor, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${cart.taxAmount.toString()} Ks",
                    style: TextStyle(
                        color: kPrimaryColor, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              const Gap(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Grand Total",
                    style: TextStyle(
                        color: kPrimaryColor, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${cart.grandTotal.toString()} Ks",
                    style: TextStyle(
                        color: kPrimaryColor, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              const Gap(15),
              CustomButton(
                name: "Order",
                function: () {},
              )
            ],
          ),
        )
      ],
    );
  }
}
