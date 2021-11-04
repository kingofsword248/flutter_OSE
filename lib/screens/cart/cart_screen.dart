import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:old_change_app/models/cart_item.dart';
import 'package:old_change_app/models/cart_request.dart';
import 'package:old_change_app/models/user.dart';
import 'package:old_change_app/presenters/check_out_presenter.dart';
import 'package:old_change_app/screens/cart/widgets/body.dart';
import 'package:old_change_app/screens/cart/widgets/check_out_card.dart';
import 'package:old_change_app/screens/detail_page/detail_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> implements CheckOutContract {
  onProductSelected(product) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => DetailScreen(item: product)));
  }

  CheckOutPresenter _checkOutPresenter;
  @override
  void initState() {
    super.initState();
    _checkOutPresenter = CheckOutPresenter(this);
  }

  Future<void> onCheckOut(List<CartModels> carts1) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      User a = User.fromJson(json.decode(prefs.get('User')));
      if (User == null) {
        return;
      }
    } on Exception catch (_) {
      print('Lỗi check out');
    }

    _checkOutPresenter.checkOut(cartRequest, a.token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Body(),
      bottomNavigationBar: CheckoutCard(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: Colors.black),
        onPressed: () => Navigator.of(context).pop(),
      ),
      backgroundColor: Colors.white,
      centerTitle: true,
      title: Column(
        children: [
          Text(
            "Your Cart",
            style: TextStyle(color: Colors.black),
          ),
          Consumer<CartList>(
            builder: (context, value, ch) {
              return Text(
                "${value.itemCount} items",
                style: Theme.of(context).textTheme.caption,
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  void OnCheckOutError() {
    // TODO: implement OnCheckOutError
  }

  @override
  void onPressCheckout(Result value) {
    // TODO: implement onPressCheckout
  }
}
