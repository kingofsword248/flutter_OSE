import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:old_change_app/data/fake.dart';
import 'package:old_change_app/models/user.dart';
import 'package:old_change_app/presenters/fetch_user_presenter.dart';
import 'package:old_change_app/screens/edit_profile/edit_profile_screen.dart';
import 'package:old_change_app/screens/purchase_order/purchase_order_screen.dart';
import 'package:old_change_app/screens/sell_order/sell_order_srceen.dart';
import 'package:old_change_app/screens/sign_in/sign_in_screen.dart';
import 'package:old_change_app/screens/upload_product/upload_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> implements FetchUserContract {
  User _a;
  User us;
  FetchUserPresenter _fetchUserPresenter;
  bool isLoading = true;
  Future<Null> getSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String user = prefs.get('User');

    setState(() {
      _a = User.fromJson(json.decode(user));
    });
  }

  @override
  void initState() {
    _fetchUserPresenter = FetchUserPresenter(this);
    super.initState();
    _a = null;
    getSharedPrefs().then((value) => _fetchUserPresenter.onFetch(_a.token));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: us == null
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                if (us != null)
                  ProfilePic(
                    address: us.avatar ?? null,
                  ),
                SizedBox(height: 20),
                if (us != null)
                  Text(
                    _a.fullName,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                SizedBox(height: 10),
                if (us != null)
                  Text(
                    "Balance: " +
                        NumberFormat.simpleCurrency(locale: 'vi')
                            .format(us.balance),
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                SizedBox(height: 20),
                ProfileMenu(
                  text: "My Account",
                  icon: "assets/icons/User Icon.svg",
                  press: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditScreen(user: us)))
                  },
                ),
                ProfileMenu(
                  text: "Purchase order",
                  icon: "assets/icons/notepad-svgrepo-com.svg",
                  press: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PurchaseOrderScreen()));
                  },
                ),
                ProfileMenu(
                  text: "Sales order",
                  icon: "assets/icons/notepad-svgrepo-com.svg",
                  press: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SellOrderScreen()));
                  },
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
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.clear().then((value) {
                      if (value)
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignInScreen()));
                    });
                  },
                ),
              ],
            ),
    );
  }

  @override
  void onFetchUserError(String onError) {
    Fake.showErrorDialog(onError, "Error", context);
  }

  @override
  void onFetchUserSuccess(User user) {
    setState(() {
      us = user;
    });
  }
}
