import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:old_change_app/screens/detail_page/widgets/bottom_sheet.dart';
import 'package:old_change_app/utilities/fake.dart';
import 'package:old_change_app/models/providers/cart_item.dart';
import 'package:old_change_app/models/product_real.dart';
import 'package:old_change_app/models/user.dart';
import 'package:old_change_app/utilities/colors.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddCart extends StatelessWidget {
  final Product product;
  const AddCart({Key key, @required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartList>(context, listen: false);
    // final prefs = await SharedPreferences.getInstance().then((value) => null)
    //                         User a;
    //                         String user = prefs.get('User');
    //                         if (user != null) {
    //                           a = User.fromJson(json.decode(user));
    //                         }
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25),
      child: Column(
        children: [
          if (!product.status.contains("EXCHANGE"))
            Container(
              alignment: Alignment.center,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      elevation: 0,
                      primary: primaryColor),
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    User a;
                    String user = prefs.get('User');
                    if (user != null) {
                      a = User.fromJson(json.decode(user));
                      if (a.id == product.own) {
                        Fake.showErrorDialog("Can't buy your product",
                            "Notification Error", context);
                        return;
                      }
                    }

                    cart.addItem(product);
                    Fake.showDiaglog(context, "Add to cart successfull");
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text('Add To Cart'),
                      Icon(Icons.add_shopping_cart_outlined)
                    ],
                  )),
            ),
          const SizedBox(
            height: 20,
          ),
          if (!product.status.contains("SELL"))
            Container(
              alignment: Alignment.center,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      elevation: 0,
                      primary: primaryColor),
                  onPressed: () {
                    _showOption(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text('Exchange'),
                      Icon(Icons.change_circle_outlined)
                    ],
                  )),
            )
        ],
      ),
    );
  }

  void _showOption(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        context: context,
        builder: (BuildContext bc) {
          return BottomSheetExchange(
            product: product,
          );
        });
  }
}
