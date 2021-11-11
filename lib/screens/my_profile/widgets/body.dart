import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:old_change_app/models/user.dart';
import 'package:old_change_app/screens/sign_in/sign_in_screen.dart';
import 'package:old_change_app/screens/upload_product/upload_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  User _a;
  Future<Null> getSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String user = prefs.get('User');
    setState(() {
      _a = User.fromJson(json.decode(user));
    });
  }

  @override
  void initState() {
    super.initState();
    _a = null;
    getSharedPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          ProfilePic(),
          SizedBox(height: 20),
          if (_a != null)
            Text(
              _a.fullName,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
          SizedBox(height: 20),
          ProfileMenu(
            text: "My Account",
            icon: "assets/icons/User Icon.svg",
            press: () => {},
          ),
          ProfileMenu(
            text: "Notifications",
            icon: "assets/icons/User Icon.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Post Products",
            icon: "assets/icons/ad-product-svgrepo-com.svg",
            press: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UploadProductScreen()));
            },
          ),
          ProfileMenu(
            text: "Help Center",
            icon: "assets/icons/User Icon.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Log Out",
            icon: "assets/icons/Log out.svg",
            press: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.clear();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SignInScreen()));
            },
          ),
        ],
      ),
    );
  }
}
