import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:old_change_app/constants/colors.dart';
import 'package:old_change_app/data/fake.dart';
import 'package:old_change_app/models/providers/cart_item.dart';
import 'package:old_change_app/models/purchase_dto.dart';
import 'package:old_change_app/screens/purchase_order/tap/confirm_screen/rating_modal_bottom_sheet.dart';

import 'package:old_change_app/widgets/size_config.dart';
import 'package:provider/provider.dart';

class ConfirmBody extends StatelessWidget {
  final PurchaseDTO dto;
  final String indexPage;
  const ConfirmBody({
    Key key,
    this.dto,
    this.indexPage,
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
              child: Image.network(dto.product[0].images[0].address),
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
                dto.product[0].name,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.black, fontSize: 18),
                maxLines: 2,
              ),
            ),
            Text(
              "Quantity : " + dto.quantity.toString(),
              style: TextStyle(fontSize: 16),
            ),
            Text(
                "Total : ${NumberFormat.simpleCurrency(locale: 'vi').format(dto.price)}",
                style: Theme.of(context).textTheme.bodyText1),
            if (indexPage.contains("3"))
              Text(
                dto.transport ?? "",
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            Wrap(
              spacing: 5,
              runSpacing: 5,
              direction: Axis.horizontal,
              children: [
                if (indexPage == "4")
                  RaisedButton(
                      child: Text("Feedback"),
                      textColor: Colors.white,
                      color: primaryColor,
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      onPressed: () => _settingModalBottomSheet(context)),
                if (indexPage == "3")
                  RaisedButton(
                      child: Text("Return"),
                      textColor: Colors.white,
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      color: Colors.red,
                      onPressed: () {})
              ],
            )
          ],
        )
      ],
    );
  }

  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        context: context,
        builder: (BuildContext bc) {
          return RatingModalBottomSheet();
        });
  }
}
