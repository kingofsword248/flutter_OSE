import 'package:flutter/material.dart';
import 'package:old_change_app/models/input/product_detail.dart';
import 'package:old_change_app/models/user.dart';
import 'package:old_change_app/screens/shop/shop_screen.dart';
import 'package:old_change_app/utilities/colors.dart';

class CardOwner extends StatelessWidget {
  final ProductDetail product;
  const CardOwner({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 100,
        color: Colors.white,
        child: Row(
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: product.avatar == null
                    ? Image.asset("assets/images/avatar.png")
                    : Image.network(product.avatar),
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.topLeft,
                child: Column(
                  children: [
                    Expanded(
                      flex: 5,
                      child: ListTile(
                        title: Text(product.fullName),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            child: Text(
                              "View Shop",
                              style: TextStyle(color: primaryColor),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ShopScreen(
                                            id: product.own,
                                            title: "Shop",
                                          )));
                            },
                          ),
                          SizedBox(
                            width: 8,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              flex: 8,
            ),
          ],
        ),
      ),
      elevation: 6,
      shadowColor: Colors.black.withOpacity(0.7),
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.white)),
    );
  }
}
