import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:old_change_app/models/providers/cart_item.dart';
import 'package:old_change_app/screens/cart/widgets/cart_card.dart';
import 'package:old_change_app/widgets/size_config.dart';
import 'package:old_change_app/data/fake.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    final cartList = Provider.of<CartList>(context);
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: ListView.builder(
        itemCount: cartList.itemCount,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Dismissible(
            key: Key(cartList.carts[index].product.idProduct.toString()),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {
              setState(() {
                // Fake.demoCart.removeAt(index);
                cartList.removeAtIndex(index);
              });
            },
            background: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: const Color(0xFFFFE6E6),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Spacer(),
                  SvgPicture.asset("assets/icons/Trash.svg"),
                ],
              ),
            ),
            child: CartCard(
              cart: cartList.carts[index],
              index: index,
            ),
          ),
        ),
      ),
    );
  }
}
