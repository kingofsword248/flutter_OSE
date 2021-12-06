import 'package:flutter/material.dart';
import 'package:old_change_app/models/input/cicle_one.dart';
import 'package:old_change_app/screens/circle_exchange/screen_2/body_two.dart';

// ignore: must_be_immutable
class CircleTwo extends StatelessWidget {
  int myIndex;
  int exchangeIndex;
  CircleOne item;
  CircleTwo({Key key, this.myIndex, this.item, this.exchangeIndex})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: const Text(
          "Circle Exchange Detail",
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            if (Navigator.canPop(context)) Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: BodyTwo(
        item: item,
        exchangeIndex: exchangeIndex,
        myIndex: myIndex,
      ),
    );
  }
}
