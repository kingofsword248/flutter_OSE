// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:old_change_app/constants/colors.dart';
import 'package:old_change_app/models/item.dart';
import 'package:old_change_app/models/product_real.dart';
import 'package:intl/intl.dart';

class ProductGirdItem extends StatefulWidget {
  final Product item;
  final EdgeInsets margin;
  const ProductGirdItem({Key key, @required this.item, this.margin})
      : super(key: key);

  @override
  State<ProductGirdItem> createState() => _ProductGirdItemState();
}

class _ProductGirdItemState extends State<ProductGirdItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin == null ? EdgeInsets.zero : widget.margin,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.11),
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
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20))),
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 20),
                  child: widget.item.images.isEmpty
                      ? Image.asset("assets/images/not.png", fit: BoxFit.cover)
                      : Image.network(
                          widget.item.images[0].address,
                          fit: BoxFit.cover,
                        ),
                ),
                if (widget.item.status != "BOTH")
                  Positioned(
                    top: 13,
                    right: 13,
                    child: Container(
                        width: 40,
                        height: 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: primaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: SvgPicture.asset(
                          widget.item.status == "SELL"
                              ? "assets/icons/money-cards-svgrepo-com.svg"
                              : "assets/icons/exchange-funds-svgrepo-com.svg",
                          color: Colors.white,
                          width: 30,
                          height: 30,
                        )),
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
                  widget.item.name,
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
                      NumberFormat.simpleCurrency(locale: 'vi')
                          .format(widget.item.price),
                      style: TextStyle(
                          fontSize: 18, color: primaryColor, height: 1.5),
                    )
                  ],
                ),
                // Container( '${widget.item.price}'
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
