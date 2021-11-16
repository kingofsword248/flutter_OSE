import 'package:flutter/material.dart';
import 'package:old_change_app/screens/sign_up/widgets/sign_up_body.dart';

class SignUpScreen extends StatelessWidget {
  static String routeName = "/sign_up";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          "Sign Up",
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => null,
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Body(),
    );
  }
}
