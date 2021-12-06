import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:old_change_app/models/input/cicle_screen1.dart';
import 'package:old_change_app/screens/circle_exchange/screen_1/circle_one.dart';
import 'package:old_change_app/screens/detail_page/detail_page.dart';
import 'package:old_change_app/utilities/colors.dart';

class CircleCard extends StatelessWidget {
  final CircleHome item;
  const CircleCard({Key key, @required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CircleOne(
                      id: item.product.idProduct,
                    )));
      },
      child: Container(
        width: 200,
        height: 254,
        child: Column(
          children: [
            Container(
              width: 200,
              height: 210,
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        offset: Offset.zero,
                        blurRadius: 15),
                  ],
                  image: DecorationImage(
                      image: item.product.images.isNotEmpty
                          ? NetworkImage(item.product.images[0].address)
                          : AssetImage("assets/images/not.png"),
                      fit: BoxFit.cover)),
            ),
            Center(
              child: Text(
                item.product.name,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black.withOpacity(0.7),
                    fontSize: 18),
              ),
            ),
            Center(
              child: Text(
                NumberFormat.simpleCurrency(locale: 'vi')
                    .format(item.product.price),
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                    fontSize: 20),
              ),
            )
          ],
        ),
      ),
    );
  }
}
