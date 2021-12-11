import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:old_change_app/models/product_real.dart';
import 'package:old_change_app/models/trending.dart';
import 'package:old_change_app/screens/detail_page/detail_page.dart';
import 'package:old_change_app/utilities/colors.dart';

class ImageCard extends StatelessWidget {
  final Trending item;
  const ImageCard({Key key, @required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailScreen(
                      productID: item.idProduct,
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
                      image: item.images.isNotEmpty
                          ? NetworkImage(item.images[0].address)
                          : const AssetImage("assets/images/not.png"),
                      fit: BoxFit.cover)),
            ),
            Center(
              child: Text(
                item.name,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black.withOpacity(0.7),
                    fontSize: 18),
              ),
            ),
            Center(
              child: Text(
                NumberFormat.simpleCurrency(locale: 'vi').format(item.price),
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
