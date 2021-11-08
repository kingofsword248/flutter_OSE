import 'package:flutter/material.dart';
import 'package:old_change_app/constants/colors.dart';
import 'package:old_change_app/models/providers/cart_item.dart';

import 'package:old_change_app/widgets/size_config.dart';
import 'package:provider/provider.dart';

class CartCard extends StatelessWidget {
  final index;
  const CartCard({
    Key key,
    @required this.cart,
    @required this.index,
  }) : super(key: key);

  final CartModels cart;

  @override
  Widget build(BuildContext context) {
    final cartList = Provider.of<CartList>(context, listen: false);
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
              child: Image.network(cart.product.images[0].address),
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
                cart.product.name,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.black, fontSize: 18),
                maxLines: 2,
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                ButtonTheme(
                  minWidth: 5,
                  height: 10,
                  child: RaisedButton(
                    padding: EdgeInsets.symmetric(horizontal: -5),
                    onPressed: () {
                      cartList.reduceQuantity(index);
                    },
                    child: Icon(
                      Icons.remove,
                      color: Colors.white,
                    ),
                    color: primaryColor,
                    splashColor: Colors.grey,
                  ),
                ),
                Consumer<CartList>(
                  builder: (context, value, ch) {
                    return Text('${value.carts[index].numOfItems}');
                  },
                ),
                ButtonTheme(
                  minWidth: 5,
                  height: 10,
                  child: RaisedButton(
                    padding: EdgeInsets.symmetric(horizontal: -5),
                    onPressed: () {
                      cartList.addQuantity(index);
                    },
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    color: primaryColor,
                    splashColor: Colors.grey,
                  ),
                ),
                Consumer<CartList>(
                  builder: (context, value, ch) {
                    return Text("Total : \$${cartList.sumOfOneItem(index)}",
                        style: Theme.of(context).textTheme.bodyText1);
                  },
                )
              ],
            )
          ],
        )
      ],
    );
  }
}
