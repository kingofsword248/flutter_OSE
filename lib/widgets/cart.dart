import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:old_change_app/constants/colors.dart';

class Cart extends StatelessWidget {
  final int numberOfItemsInCart;
  const Cart({Key key, @required this.numberOfItemsInCart}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      overflow: Overflow.visible,
      children: [
        Container(
          width: 24,
          height: 24.0,
          child: SvgPicture.asset('assets/icons/cart.svg'),
        ),
        Positioned(
          top: -4,
          right: -4,
          child: Container(
            width: 12,
            height: 12,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: primaryColor,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 1.0)),
            child: Text(
              '$numberOfItemsInCart',
              style: TextStyle(
                  fontSize: 8.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        )
      ],
    );
  }
}
