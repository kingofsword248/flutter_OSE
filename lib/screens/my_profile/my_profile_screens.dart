import 'package:flutter/material.dart';
import 'package:old_change_app/screens/my_profile/widgets/body.dart';
import 'package:old_change_app/widgets/app_bottom_navigation.dart';
// import 'package:shop_app/components/coustom_bottom_nav_bar.dart';

class ProfileScreen extends StatelessWidget {
  // static String routeName = "/profile";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile",
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => null,
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        brightness: Brightness.light,
      ),
      body: Body(),
      bottomNavigationBar: AppBottomNavigation(),
    );
  }
}
