import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:old_change_app/constants/colors.dart';
import 'package:old_change_app/data/fake.dart';
import 'package:old_change_app/models/providers/cart_item.dart';
import 'package:old_change_app/models/product_real.dart';
import 'package:old_change_app/models/user.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_select/smart_select.dart';

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
                      Text('Trade'),
                      Icon(Icons.change_circle_outlined)
                    ],
                  )),
            )
        ],
      ),
    );
  }

  void close(context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }

  void _showOption(BuildContext context) {
    String value = 'ion';
    List<S2Choice<String>> options = [
      S2Choice<String>(value: 'ion', title: 'Ionic'),
      S2Choice<String>(value: 'flu', title: 'Flutter'),
      S2Choice<String>(value: 'rea', title: 'React Native'),
    ];
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        context: context,
        builder: (BuildContext bc) {
          return SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(28),
              child: Wrap(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 100,
                        alignment: Alignment.centerLeft,
                        child: InkWell(
                          child: Icon(Icons.close),
                          onTap: () {
                            close(context);
                          },
                        ),
                      ),
                      Text(
                        'Trade',
                        textAlign: TextAlign.center,
                      ),
                      Container(
                        width: 100,
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () {},
                          child: Text(
                            '',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  if (!options.isEmpty)
                    SmartSelect.single(
                      title: 'Select the product you want to exchange',
                      value: value,
                      onChange: (state) => value = state.value,
                      choiceItems: options,
                      modalType: S2ModalType.popupDialog,
                    ),
                  if (options.isEmpty)
                    const Text(
                      'You dont have any product to trade',
                      textAlign: TextAlign.center,
                    ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(vertical: 20),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7)),
                      textColor: Colors.white,
                      color: primaryColor,
                      padding: EdgeInsets.all(20),
                      child: Text(
                        'Request to Trade',
                        style: TextStyle(fontSize: 16),
                      ),
                      onPressed: () {
                        close(context);
                      },
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
