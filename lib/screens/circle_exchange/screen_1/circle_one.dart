import 'package:flutter/material.dart';
import 'package:old_change_app/models/user.dart';
import 'package:old_change_app/screens/circle_exchange/screen_1/body_one.dart';

// ignore: must_be_immutable
class CircleOne extends StatelessWidget {
  int id;

  CircleOne({Key key, this.id}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: const Text(
          "Circle Exchange",
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
      body: BodyOne(
        id: id,
      ),
    );
  }
}
