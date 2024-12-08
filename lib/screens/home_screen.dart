import 'package:bloc_api/BLoC/cubits/auth/auth_cubit.dart';
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
      appBar: AppBar(
        centerTitle: true,
        title: Column(
          children: [
            Text("H O M E"),
            const Gap(15),
            Text(authCubit.currentUser?.name ?? "")
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.person)),
          IconButton(
              onPressed: () => authCubit.logoutUser(context),
              icon: Icon(Icons.logout_rounded))
        ],
      ),
    ));
  }
}
