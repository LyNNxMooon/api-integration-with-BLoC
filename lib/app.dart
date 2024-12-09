import 'package:bloc_api/BLoC/cubits/auth/auth_cubit.dart';
import 'package:bloc_api/BLoC/cubits/auth/auth_states.dart';
import 'package:bloc_api/BLoC/cubits/products/product_cubit.dart';
import 'package:bloc_api/data/models/auth_model.dart';
import 'package:bloc_api/data/models/product_model.dart';
import 'package:bloc_api/screens/auth_screen.dart';
import 'package:bloc_api/screens/home_screen.dart';
import 'package:bloc_api/utils/navigation_extension.dart';
import 'package:bloc_api/widgets/error_widget.dart';
import 'package:bloc_api/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final authRepo = AuthModel();
  final productsRepo = ProductModel();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(authRepo: authRepo)..checkAuth(),
        ),
        BlocProvider<ProductsCubit>(
          create: (context) =>
              ProductsCubit(productRepo: productsRepo)..getAllProducts(),
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: BlocConsumer<AuthCubit, AuthStates>(
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
