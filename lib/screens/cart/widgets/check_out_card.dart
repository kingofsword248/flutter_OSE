import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:old_change_app/data/fake.dart';
import 'package:old_change_app/models/cart_item.dart';
import 'package:old_change_app/screens/cart/widgets/default_button.dart';
import 'package:old_change_app/widgets/size_config.dart';
import 'package:provider/provider.dart';

class CheckoutCard extends StatelessWidget {
  final Function oncheckOut;
  const CheckoutCard({Key key, this.oncheckOut}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartList = Provider.of<CartList>(context);
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
                          oncheckOut;
                        },
                      ),
                    ),
                  ],
                ),
              ]),
        ));
  }
}
