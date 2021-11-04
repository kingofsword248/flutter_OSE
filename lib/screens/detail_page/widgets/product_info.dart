// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:old_change_app/constants/colors.dart';

import 'package:old_change_app/models/product_real.dart';
import 'package:old_change_app/screens/detail_page/widgets/add_cart.dart';
import 'package:old_change_app/screens/detail_page/widgets/owner_card.dart';
import 'package:readmore/readmore.dart';

class ProductInfo extends StatelessWidget {
  final Product item;
  const ProductInfo({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${item.name}',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              const Text('Price ',
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 20,
                      color: Colors.grey)),
              Text(
                '\$${item.price}',
                style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w800,
                    fontSize: 20),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              const Text(
                'Rating ',
                style: TextStyle(color: Colors.grey),
              ),
              Icon(
                Icons.star_border,
                color: Colors.yellow,
              ),
              Text(
                '${item.rating}',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    offset: Offset.zero,
                    blurRadius: 15.0,
                  ),
                ],
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Description :',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                ReadMoreText(
                  item.description,
                  trimLines: 3,
                  textAlign: TextAlign.justify,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: 'Read more',
                  trimExpandedText: ' Less',
                  lessStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                  moreStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.7),
                      fontSize: 15,
                      height: 1),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          CardOwner(),
          AddCart(
            product: item,
          )
        ],
      ),
    );
  }
}
