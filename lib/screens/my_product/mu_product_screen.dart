import 'package:flutter/material.dart';
import 'package:old_change_app/screens/my_product/widgets/body.dart';

class MyProduct extends StatefulWidget {
  const MyProduct({Key key}) : super(key: key);

  @override
  _MyProductState createState() => _MyProductState();
}

class _MyProductState extends State<MyProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Body(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: Colors.black),
        onPressed: () => Navigator.of(context).pop(),
      ),
      backgroundColor: Colors.white,
      centerTitle: true,
      title: Text(
        "My product",
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
