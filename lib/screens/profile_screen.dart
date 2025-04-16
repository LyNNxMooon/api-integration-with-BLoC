import 'package:bloc_api/BLoC/auth/auth_bloc.dart';
import 'package:bloc_api/constants/colors.dart';
import 'package:bloc_api/utils/navigation_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final authBloc = context.read<AuthBloc>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: kThirdColor,
        centerTitle: true,
        leading: IconButton(
            onPressed: () => context.navigateBack(),
            icon: Icon(
              Icons.home_filled,
              color: kPrimaryColor,
            )),
        title: Text(
          authBloc.currentUser?.name ?? "Unknown User",
          style: TextStyle(
              color: kPrimaryColor, fontSize: 15, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.edit,
                color: kPrimaryColor,
              )),
        ],
      ),
      body: SingleChildScrollView(
        physics: RangeMaintainingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const Gap(25),
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.25),
              height: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1), // Shadow color
                    spreadRadius: 3, // Spread radius
                    blurRadius: 5, // Blur radius
                    offset: const Offset(0, 3), // Offset of the shadow
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  "https://th.bing.com/th/id/OIP.nKQPQmPIbsxlkwVrTCuGLAHaGO?rs=1&pid=ImgDetMain",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const Gap(10),
            Center(
              child: Text(
                authBloc.currentUser?.email ?? "exmaple@mail.com",
                style:
                    TextStyle(fontWeight: FontWeight.w500, color: kFourthColor),
              ),
            ),
            const Gap(5),
            Center(
              child: Text(
                authBloc.currentUser?.phone ?? "01-0000000",
                style:
                    TextStyle(fontWeight: FontWeight.w500, color: kFourthColor),
              ),
            ),
            const Gap(25),
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
                      child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container()
                      ],),
            )
          ],
        ),
      ),
    ));
  }
}
