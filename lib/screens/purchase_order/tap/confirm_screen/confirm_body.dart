import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:old_change_app/constants/colors.dart';
import 'package:old_change_app/data/fake.dart';
import 'package:old_change_app/models/providers/cart_item.dart';

import 'package:old_change_app/widgets/size_config.dart';
import 'package:provider/provider.dart';

class ConfirmBody extends StatelessWidget {
  final index;
  const ConfirmBody({
    Key key,
    @required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final cartList = Provider.of<CartList>(context, listen: false);
    return Row(
      children: [
        SizedBox(
          width: 88,
          child: AspectRatio(
            aspectRatio: 0.88,
            child: Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(10)),
              decoration: BoxDecoration(
                color: Color(0xFFF5F6F9),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.asset(Fake.product2[index].images[0].address),
            ),
          ),
        ),
        SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: getProportionateScreenWidth(220),
              child: Text(
                Fake.product2[index].name,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.black, fontSize: 18),
                maxLines: 2,
              ),
            ),
            Text(
              "Quantity : " + Fake.product2[index].quantity.toString(),
              style: TextStyle(fontSize: 16),
            ),
            Text(
                "Total : ${NumberFormat.simpleCurrency(locale: 'vi').format(Fake.product2[index].price)}",
                style: Theme.of(context).textTheme.bodyText1)
          ],
        )
      ],
    );
  }
}
