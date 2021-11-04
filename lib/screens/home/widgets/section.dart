import 'package:flutter/material.dart';
import 'package:old_change_app/constants/colors.dart';

class Section extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const Section(this.title, this.children, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 28),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 20, height: 1),
              ),
              InkWell(
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                      'View all',
                      style: TextStyle(
                        fontSize: 18,
                        height: 1,
                        color: primaryColor,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Icon(
                        Icons.arrow_forward,
                        color: primaryColor,
                      ),
                    )
                  ],
                ),
                onTap: () {},
              )
            ],
          ),
        ),
        Container(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.all(28.0),
              child: Wrap(
                spacing: 28,
                children: children,
              ),
            ),
          ),
        )
      ],
    );
  }
}
