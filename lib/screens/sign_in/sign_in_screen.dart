import 'package:flutter/material.dart';
import 'package:old_change_app/screens/sign_in/widgets/sign_in_body.dart';
import 'package:old_change_app/widgets/app_bottom_navigation.dart';

class SignInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: AppBottomNavigation(),
      // appBar: AppBar(
      //   title: const Text(
      //     "Sign In",
      //     style: TextStyle(color: Colors.black),
      //   ),
      //   leading: IconButton(
      //     icon: Icon(Icons.arrow_back_ios, color: Colors.white),
      //     onPressed: () => null,
      //   ),
      //   backgroundColor: Colors.white,
      //   centerTitle: true,
      // ),
      body: Body(),
    );
  }
}
