// ignore_for_file: deprecated_member_use

import 'package:bloc_api/BLoC/auth/auth_bloc.dart';
import 'package:bloc_api/BLoC/auth/auth_events.dart';
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
                  horizontal: MediaQuery.of(context).size.width * 0.27),
              height: 160,
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
              //height: double.infinity,
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
                  color: kThirdColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    width: double.infinity,
                    //  height: 50,
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        color: kPrimaryColor,
                        boxShadow: [
                          BoxShadow(
                            color:
                                Colors.black.withOpacity(0.1), // Shadow color
                            spreadRadius: 4, // Spread radius
                            blurRadius: 5, // Blur radius
                            offset: const Offset(0, 0), // Offset of the shadow
                          ),
                        ],
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.person,
                              color: kSecondaryColor,
                            ),
                            const Gap(10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Edit Profile",
                                  style: TextStyle(
                                      color: kFourthColor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                                const Gap(3),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.55,
                                  child: Text(
                                    "Edit your personal informaiton",
                                    style: TextStyle(
                                      color: kSecondaryColor,
                                      fontSize: 12.5,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: kSecondaryColor,
                        )
                      ],
                    ),
                  ),
                  const Gap(30),
                  profileCard(Icons.history, "Order History",
                      "View all your orders history"),
                  const Gap(30),
                  profileCard(
                      Icons.phone, "Contact Us", "Contact to our support team"),
                  const Gap(30),
                  profileCard(Icons.edit_document, "Terms & Conditions",
                      "Read our terms and regulatory guidelines"),
                  const Gap(30),
                  GestureDetector(
                    onTap: () {
                      context.navigateBack();
                      authBloc.add(LogoutEvent());
                    } ,
                    child: profileCard(
                        Icons.logout, "Logout", "Logout From Your Account"),
                  ),
                  const Gap(60),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }

  Widget profileCard(IconData icon, String title, String desc) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      //height: 60,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: kPrimaryColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1), // Shadow color
            spreadRadius: 4, // Spread radius
            blurRadius: 5, // Blur radius
            offset: const Offset(0, 0), // Offset of the shadow
          ),
        ],
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: kSecondaryColor,
              ),
              const Gap(10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        color: kFourthColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                  const Gap(3),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.55,
                    child: Text(
                      desc,
                      style: TextStyle(
                        color: kSecondaryColor,
                        fontSize: 12.5,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
          Icon(
            Icons.arrow_forward_ios_rounded,
            color: kSecondaryColor,
          )
        ],
      ),
    );
  }
}
