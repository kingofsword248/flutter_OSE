import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:old_change_app/data/fake.dart';
import 'package:old_change_app/screens/purchase_order/tap/confirm_screen/confirm_body.dart';
import 'package:old_change_app/widgets/size_config.dart';

class ConfirmTap extends StatefulWidget {
  const ConfirmTap({Key key}) : super(key: key);

  @override
  _ConfirmTapState createState() => _ConfirmTapState();
}

class _ConfirmTapState extends State<ConfirmTap> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: ListView.builder(
          itemCount: Fake.product2.length,
          itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Dismissible(
                  key: Key(Fake.product2[index].idProduct.toString()),
                  onDismissed: null,
                  confirmDismiss: (direction) {
                    return showDialog(
                      context: context,
                      builder: (context) {
                        return CupertinoAlertDialog(
                          title: Text('Delete'),
                          content: Text('Delete'),
                          actions: <Widget>[
                            FlatButton(
                              onPressed: () {
                                // Navigator.pop(context, false);
                                Navigator.of(
                                  context,
                                  // rootNavigator: true,
                                ).pop(false);
                              },
                              child: Text('No'),
                            ),
                            FlatButton(
                              onPressed: () {
                                // Navigator.pop(context, true);
                                Navigator.of(
                                  context,
                                  // rootNavigator: true,
                                ).pop(true);
                              },
                              child: Text('Yes'),
                            ),
                          ],
                        );
                      },
                    );
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
                  child: ConfirmBody(
                    index: index,
                  ),
                ),
              )),
    );
  }
}
