import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("H O M E"),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.person))],
      ),
    ));
  }
}
