// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:old_change_app/constants/colors.dart';
import 'package:old_change_app/models/item.dart';
import 'package:old_change_app/models/product_real.dart';

class ProductGirdItem extends StatelessWidget {
  final Product item;
  final EdgeInsets margin;
  const ProductGirdItem({Key key, @required this.item, this.margin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin == null ? EdgeInsets.zero : margin,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(7),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                offset: Offset.zero,
                blurRadius: 15)
          ]),
      child: Column(
        children: [
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 37),
                  child: Image.network(
                    item.images[0].address,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  item.name,
                  overflow: TextOverflow.ellipsis,
                  // overflow: TextOverflow.ellipsis,
                  style:
                      TextStyle(color: Colors.black, fontSize: 14, height: 1.5),
                ),
                Wrap(
                  spacing: 3,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                      '${item.price}',
                      style: TextStyle(
                          fontSize: 18, color: primaryColor, height: 1.5),
                    )
                  ],
                ),
                // Container(
                //     margin: EdgeInsets.only(top: 5),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //         RatingBar.builder(
                //             // initialRating: item.rating,
                //             itemSize: 12,
                //             ignoreGestures: true,
                //             itemCount: 5,
                //             allowHalfRating: true,
                //             minRating: 1,
                //             unratedColor: Colors.amber[100],
                //             itemBuilder: (context, _) => Icon(
                //                   Icons.star,
                //                   size: 2,
                //                   color: Colors.amber,
                //                 ),
                //             onRatingUpdate: null),
                //         SizedBox(
                //           width: 5,
                //         ),
                //         // Text(
                //         //   '${item.rating}',
                //         //   style: TextStyle(fontSize: 12),
                //         // )
                //       ],
                //     ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
