import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:old_change_app/models/cart_item.dart';
import 'package:old_change_app/models/cart_request.dart';
import 'package:old_change_app/models/user.dart';
import 'package:old_change_app/presenters/check_out_presenter.dart';
import 'package:old_change_app/screens/cart/widgets/body.dart';
import 'package:old_change_app/screens/cart/widgets/default_button.dart';
import 'package:old_change_app/screens/detail_page/detail_page.dart';
import 'package:old_change_app/screens/sign_in/sign_in_screen.dart';
import 'package:old_change_app/widgets/size_config.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> implements CheckOutContract {
  CheckOutPresenter _checkOutPresenter;
  Result rs;
  @override
  void initState() {
    super.initState();
    _checkOutPresenter = CheckOutPresenter(this);
  }

  // onProductSelected(product) {
  //   Navigator.push(context,
  //       MaterialPageRoute(builder: (context) => DetailScreen(item: product)));
  // }

  Future<void> onCheckOut(List<CartModels> carts1) async {
    CartRequest cartRequest;
    final prefs = await SharedPreferences.getInstance();
    User a;
    String user = prefs.get('User');
    try {
      if (user != null) a = User.fromJson(json.decode(user));
    } on Exception catch (_) {
      print('Lỗi check out');
    }
    if (a != null) {
      if (carts1.isNotEmpty) {
        cartRequest = CartList.convertCart(carts1, a.id);
        _checkOutPresenter.checkOut(cartRequest, a.token);
      } else {
        _showErrorDialog("Your cart is empty. Please buy more");
      }
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SignInScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartList = Provider.of<CartList>(context, listen: false);
    return Scaffold(
      appBar: buildAppBar(context),
      body: Body(),
      bottomNavigationBar: CheckOutCard2(context),
    );
  }

  Widget CheckOutCard2(BuildContext context) {
    final cartList = Provider.of<CartList>(context, listen: false);
    return Container(
        padding: EdgeInsets.symmetric(
          vertical: getProportionateScreenWidth(15),
          horizontal: getProportionateScreenWidth(30),
        ),
        // height: 174,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, -15),
              blurRadius: 20,
              color: Color(0xFFDADADA).withOpacity(0.15),
            )
          ],
        ),
        child: SafeArea(
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Consumer<CartList>(builder: (context, value, ch) {
                      return Text.rich(
                        TextSpan(
                          text: "Total:\n",
                          children: [
                            TextSpan(
                              text: "\$ ${value.sum()}",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black),
                            ),
                          ],
                        ),
                      );
                    }),
                    SizedBox(
                      width: getProportionateScreenWidth(190),
                      child: DefaultButton(
                        text: "Check Out",
                        press: () {
                          onCheckOut(cartList.carts);
                        },
                      ),
                    ),
                  ],
                ),
              ]),
        ));
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
  void OnCheckOutError(String error) {
    if (error.contains("token")) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SignInScreen()));
    } else {
      _showErrorDialog(error);
    }
  }

  @override
  void onPressCheckout(Result value) {
    if (value.result.contains("thành công")) {
      final cartList = Provider.of<CartList>(context, listen: false);
      cartList.clearCart();
    }
    _showErrorDialog(value.result);
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An Error Occurred!'),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }
}
