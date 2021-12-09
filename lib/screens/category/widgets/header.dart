import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:old_change_app/utilities/fake.dart';
import 'package:old_change_app/models/category.dart';
import 'package:old_change_app/models/providers/cart_item.dart';
import 'package:old_change_app/screens/cart/cart_screen.dart';
import 'package:old_change_app/screens/category/widgets/action_button.dart';
import 'package:old_change_app/screens/category/widgets/filter_modal_bottom_sheet.dart';
import 'package:old_change_app/widgets/cart.dart';
import 'package:provider/provider.dart';

class Header extends StatelessWidget {
  final String content;
  final List<Categories> list;
  const Header({Key key, this.content, @required this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: Offset(0.0, 10),
            blurRadius: 10)
      ]),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 60,
                  alignment: Alignment.centerLeft,
                  child: InkWell(
                    child: SvgPicture.asset('assets/icons/back.svg'),
                    onTap: () {
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      }
                    },
                  ),
                ),
                Text(
                  content,
                  style: TextStyle(fontSize: 18),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: Wrap(
                    spacing: 8,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      // SvgPicture.asset(
                      //   'assets/icons/search.svg',
                      //   height: 18,
                      // ),
                      InkWell(onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CartScreen()));
                      }, child:
                          Consumer<CartList>(builder: (context, value, child) {
                        return Cart(numberOfItemsInCart: value.itemCount);
                      })),

                      ActionButton(
                        onTap: () {
                          _settingModalBottomSheet(context, list);
                        },
                        active: true,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _settingModalBottomSheet(context, List<Categories> list) {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        context: context,
        builder: (BuildContext bc) {
          return FilterModalBottomSheet(
            list: list,
          );
        });
  }
}
