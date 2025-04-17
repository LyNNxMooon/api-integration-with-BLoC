// ignore_for_file: deprecated_member_use

import 'package:bloc_api/BLoC/cart/cart_bloc.dart';
import 'package:bloc_api/BLoC/cart/cart_events.dart';
import 'package:bloc_api/BLoC/cart/cart_states.dart';
import 'package:bloc_api/constants/colors.dart';
import 'package:bloc_api/constants/image.dart';
import 'package:bloc_api/data/vos/cart_item_vo.dart';
import 'package:bloc_api/utils/navigation_extension.dart';
//import 'package:bloc_api/widgets/button_widget.dart';
import 'package:bloc_api/widgets/error_widget.dart';
import 'package:bloc_api/widgets/loading_widget.dart';
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
          style: TextStyle(
              color: kPrimaryColor, fontSize: 15, fontWeight: FontWeight.bold),
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
            return state.cart.isEmpty ? emptyCartUI() : cartUI(state.cart);
          } else {
            return SizedBox();
          }
        },
        listener: (context, state) {
          if (state is CartUpdated) {
            showDialog(
              context: context,
              builder: (context) =>
                  SuccessWidget(message: "Cart Updated Successfully!"),
            );
          }

      

          if (state is CartRemoved) {
            showDialog(
              context: context,
              builder: (context) =>
                  SuccessWidget(message: state.removeResponse.message),
            );
          }
        },
      ),
      bottomNavigationBar: BlocBuilder<CartBloc, CartStates>(
        builder: (context, state) {
          if (state is CartLoaded && state.cart.isNotEmpty) {
            return bottomNaviUI(state.cart);
          } else {
            return SizedBox();
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
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.4),
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
    return ListView.separated(
        padding: EdgeInsets.symmetric(vertical: 20),
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
        itemCount: 5);
  }

  Widget cartUI(List<CartItemVO> cart) {
    return RefreshIndicator(
      backgroundColor: kPrimaryColor,
      color: kSecondaryColor,
      onRefresh: () async {
        cartBloc.add(GetCart());
      },
      child: ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          itemBuilder: (context, index) => Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                width: double.infinity,
                //height: 100,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1), // Shadow color
                        spreadRadius: 3, // Spread radius
                        blurRadius: 5, // Blur radius
                        offset: const Offset(0, 3), // Offset of the shadow
                      ),
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () =>
                          cartBloc.add(RemoveCart(cartID: cart[index].id)),
                      child: Container(
                        width: 18,
                        height: 18,
                        decoration: BoxDecoration(
                            color: kSecondaryColor,
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                          child: Icon(
                            Icons.remove,
                            size: 14,
                            color: kPrimaryColor,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(5)),
                      width: 55,
                      height: 75,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: CachedNetworkImage(
                            imageUrl:
                                cart[index].product.image['path'].isEmpty
                                    ? productImagePlaceholder
                                    : cart[index].product.image['path'],
                            fit: BoxFit.cover,
                            errorWidget: (context, url, error) => Icon(
                                  Icons.error,
                                  color: kFourthColor,
                                ),
                            placeholder: (context, url) =>
                                ImageLoadingWidget()),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.42,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            cart[index].product.name,
                            style: TextStyle(fontSize: 13, color: kSecondaryColor),
                          ),
                          const Gap(5),
                          Text(
                            "${cart[index].quantity * double.parse(cart[index].product.price)} Ks",
                            style: TextStyle(
                              fontSize: 11.5,
                                fontWeight: FontWeight.bold,
                                color: kThirdColor),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () => cartBloc.add(UpdateCart(
                              cartID: cart[index].id,
                              qty: cart[index].quantity + 1)),
                          child: Container(
                            width: 18,
                            height: 18,
                            decoration: BoxDecoration(
                                color: kThirdColor,
                                borderRadius: BorderRadius.circular(20)),
                            child: Center(
                              child: Icon(
                                Icons.add,
                                size: 14,
                                color: kPrimaryColor,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Text(cart[index].quantity.toString(), style: TextStyle(color: kSecondaryColor),),
                        ),
                        GestureDetector(
                          onTap: () => cartBloc.add(UpdateCart(
                              cartID: cart[index].id,
                              qty: cart[index].quantity - 1)),
                          child: Container(
                            width: 18,
                            height: 18,
                            decoration: BoxDecoration(
                                color: kThirdColor,
                                borderRadius: BorderRadius.circular(20)),
                            child: Center(
                              child: Icon(
                                Icons.remove,
                                size: 14,
                                color: kPrimaryColor,
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
          itemCount: cart.length),
    );
  }

  Widget bottomNaviUI(List<CartItemVO> cart) {
    String calculateTotal() {
      double total = 0;

      for (CartItemVO cartItem in cart) {
        total += cartItem.quantity * double.parse(cartItem.product.price);
      }

      return total.toString();
    }

    return Container(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      height: 180,
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
                "${calculateTotal()} Ks",
                style: TextStyle(
                    color: kPrimaryColor, fontWeight: FontWeight.bold),
              )
            ],
          ),
          const Gap(10),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Text(
          //       "Tax",
          //       style: TextStyle(
          //           color: kPrimaryColor, fontWeight: FontWeight.bold),
          //     ),
          //     Text(
          //       cart.tax!,
          //       style: TextStyle(
          //           color: kPrimaryColor, fontWeight: FontWeight.bold),
          //     )
          //   ],
          // ),
          // const Gap(10),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Text(
          //       "Tax Amount",
          //       style: TextStyle(
          //           color: kPrimaryColor, fontWeight: FontWeight.bold),
          //     ),
          //     Text(
          //       "${cart.taxAmount.toString()} Ks",
          //       style: TextStyle(
          //           color: kPrimaryColor, fontWeight: FontWeight.bold),
          //     )
          //   ],
          // ),
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
                "${calculateTotal()} Ks",
                style: TextStyle(
                    color: kPrimaryColor, fontWeight: FontWeight.bold),
              )
            ],
          ),
          const Gap(25),
          GestureDetector(
      onTap: () {
        
      },
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.all(Radius.circular(15)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1), // Shadow color
              spreadRadius: 3, // Spread radius
              blurRadius: 5, // Blur radius
              offset: const Offset(0, 3), // Offset of the shadow
            ),
          ],
        ),
        child: Center(
          child: Text(
            "Order",
            style: const TextStyle(
              color: kThirdColor,
              fontSize: 16,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
      ),
    )
        ],
      ),
    );
  }
}
