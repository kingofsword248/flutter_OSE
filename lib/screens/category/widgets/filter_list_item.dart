import 'package:flutter/material.dart';
import 'package:old_change_app/constants/colors.dart';

class FilterListItem extends StatelessWidget {
  final Widget icon;
  final String title;
  final bool selected;
  final Function() onTap;

  const FilterListItem({
    Key key,
    @required this.icon,
    @required this.title,
    @required this.onTap,
    this.selected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.black12))),
        child: Row(
          children: [
            Container(
              height: 30,
              width: 30,
              child: icon,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  title,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            if (selected)
              Icon(
                Icons.check,
                color: primaryColor,
              )
          ],
        ),
      ),
    );
  }
}
