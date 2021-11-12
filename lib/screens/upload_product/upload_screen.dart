import 'package:flutter/material.dart';
import 'package:old_change_app/screens/upload_product/widgets/body.dart';

class UploadProductScreen extends StatelessWidget {
  const UploadProductScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Upload Product",
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        brightness: Brightness.light,
      ),
      body: Body(),
    );
  }
}
