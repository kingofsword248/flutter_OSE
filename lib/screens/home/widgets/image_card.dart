import 'package:flutter/material.dart';
import 'package:old_change_app/models/product_real.dart';
import 'package:old_change_app/screens/detail_page/detail_page.dart';

class ImageCard extends StatelessWidget {
  final Product item;
  const ImageCard({Key key, @required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailScreen(
                      item: item,
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
                      image: AssetImage(this.item.images[0].address),
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
                '\$${item.price}',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.blue.shade800,
                    fontSize: 20),
              ),
            )
          ],
        ),
      ),
    );
  }
}
