import 'package:bloc_api/BLoC/auth/auth_bloc.dart';
import 'package:bloc_api/BLoC/auth/auth_events.dart';
import 'package:bloc_api/BLoC/auth/auth_states.dart';
import 'package:bloc_api/BLoC/banner/banner_bloc.dart';
import 'package:bloc_api/BLoC/banner/banner_events.dart';
import 'package:bloc_api/BLoC/cart/cart_bloc.dart';
import 'package:bloc_api/BLoC/cart/cart_events.dart';
import 'package:bloc_api/BLoC/products/product_bloc.dart';
import 'package:bloc_api/BLoC/products/product_events.dart';
import 'package:bloc_api/data/models/auth_model.dart';
import 'package:bloc_api/data/models/cart_model.dart';
import 'package:bloc_api/data/models/product_model.dart';
import 'package:bloc_api/screens/auth_screen.dart';
import 'package:bloc_api/screens/home_screen.dart';
import 'package:bloc_api/utils/navigation_extension.dart';
import 'package:bloc_api/widgets/error_dialog.dart';
import 'package:bloc_api/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final authRepo = AuthModel();
  final productsRepo = ProductModel();
  final cartRepo = CartModel();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) =>
              AuthBloc(authRepo: authRepo)..add(CheckUserAuth()),
        ),
        BlocProvider<ProductsBloc>(
          create: (context) =>
              ProductsBloc(productRepo: productsRepo)..add(FetchProducts()),
        ),
        BlocProvider<CartBloc>(
          create: (context) => CartBloc(cartRepo: cartRepo)..add(GetCart()),
        ),
        BlocProvider<BannerBloc>(
          create: (context) =>
              BannerBloc(productRepo: productsRepo)..add(FetchBanners()),
        )
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: BlocConsumer<AuthBloc, AuthStates>(
            builder: (context, authState) {
              return authState is Unauthenticated
                  ? const AuthScreen()
                  : authState is Authenticated
                      ? const HomeScreen()
                      : const CustomLoadingWidget();
            },
            listener: (context, authState) {
              if (authState is AuthError) {
                showDialog(
                  context: context,
                  builder: (context) => CustomErrorWidget(
                    errorMessage: authState.message,
                    function: () => context.navigateBack(),
                  ),
                );
              }
            },
          )),
    );
  }
}
