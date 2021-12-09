import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:old_change_app/models/info.dart';
import 'package:old_change_app/utilities/colors.dart';
import 'package:old_change_app/utilities/fake.dart';
import 'package:old_change_app/models/category.dart';
import 'package:old_change_app/models/providers/cart_item.dart';
import 'package:old_change_app/screens/cart/cart_screen.dart';
import 'package:old_change_app/screens/category/widgets/action_button.dart';
import 'package:old_change_app/screens/category/widgets/filter_modal_bottom_sheet.dart';
import 'package:old_change_app/widgets/cart.dart';
import 'package:provider/provider.dart';

class Header2 extends StatelessWidget {
  final String content;
  final Info info;
  const Header2({Key key, this.content, this.info}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: const DecorationImage(
              image: AssetImage("assets/images/22k.jpg"), fit: BoxFit.cover),
          // color: primaryColor,
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(5)),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                offset: Offset(0.0, 10),
                blurRadius: 10)
          ]),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 60,
                  alignment: Alignment.centerLeft,
                  child: InkWell(
                    child: SvgPicture.asset(
                      'assets/icons/back.svg',
                      color: Colors.white,
                    ),
                    onTap: () {
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      }
                    },
                  ),
                ),
                Text(
                  content,
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w800),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: Wrap(
                    spacing: 8,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      // SvgPicture.asset(
                      //   'assets/icons/search.svg',
                      //   height: 18,
                      // ),
                      InkWell(onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CartScreen()));
                      }, child:
                          Consumer<CartList>(builder: (context, value, child) {
                        return Cart(numberOfItemsInCart: value.itemCount);
                      })),
                    ],
                  ),
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                height: 120,
                child: CircleAvatar(
                  child: Image.network(info.avatar),
                  radius: 60,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Name : " + info.fullName,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Text(
                    "Phone : " + info.phone,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Text(
                    "Adress : " + info.address,
                    overflow: TextOverflow.visible,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  RatingBar.builder(
                      initialRating: double.parse(info.starUser),
                      itemSize: 18,
                      ignoreGestures: true,
                      itemCount: 5,
                      allowHalfRating: true,
                      minRating: 1,
                      unratedColor: Colors.amber[100],
                      itemBuilder: (context, _) => Icon(
                            Icons.star,
                            size: 2,
                            color: Colors.amber,
                          ),
                      onRatingUpdate: null),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
