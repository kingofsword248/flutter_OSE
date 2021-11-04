import 'package:flutter/material.dart';
import 'package:old_change_app/data/fake.dart';
import 'package:old_change_app/models/cart_item.dart';
import 'package:old_change_app/screens/cart/cart_screen.dart';
import 'package:old_change_app/screens/home/widgets/search_bar.dart';
import 'package:old_change_app/widgets/cart.dart';
import 'package:provider/provider.dart';

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 28.0, vertical: 16.0),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Old Change Shop",
                style: TextStyle(
                    fontSize: 28.0, height: 1, fontWeight: FontWeight.bold),
              ),
              InkWell(onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CartScreen()));
              }, child: Consumer<CartList>(builder: (context, value, child) {
                return Cart(numberOfItemsInCart: value.itemCount);
              })),
            ],
          ),
          Text(
            '',
            style:
                TextStyle(fontSize: 15.0, height: 2.0, color: Colors.black38),
          ),
          SearchBar()
        ],
      ),
    );
  }
}
