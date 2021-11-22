import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:old_change_app/utilities/colors.dart';

class ActionButton extends StatelessWidget {
  final Function onTap;
  final bool active;
  const ActionButton({
    Key key,
    this.onTap,
    this.active = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5),
      child: InkWell(
        onTap: onTap,
        child: Wrap(
          spacing: 8,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/icons/controls.svg',
              color: Colors.black,
            ),
            Stack(
              overflow: Overflow.visible,
              children: [
                Text(
                  '',
                ),
                if (active)
                  Positioned(
                      top: -3,
                      right: -3,
                      child: Container(
                        width: 14,
                        height: 14,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: primaryColor,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 1)),
                        child: SvgPicture.asset(
                          'assets/icons/tick.svg',
                          height: 5,
                          color: Colors.white,
                        ),
                      ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
