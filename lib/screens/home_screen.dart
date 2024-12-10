import 'package:bloc_api/BLoC/cubits/auth/auth_cubit.dart';
import 'package:bloc_api/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
    return SafeArea(
        child: Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        backgroundColor: kThirdColor,
        centerTitle: true,
        title: Column(
          children: [
            const Gap(10),
            Text("H O M E"),
            const Gap(4),
            Text(
              authCubit.currentUser?.name ?? "",
              style: TextStyle(fontSize: 14),
            )
          ],
        ),
        actions: [
          IconButton(
              onPressed: () => authCubit.logoutUser(context),
              icon: Icon(Icons.logout_rounded))
        ],
      ),
    ));
  }
}
