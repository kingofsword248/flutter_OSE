import 'package:flutter/material.dart';

import 'package:old_change_app/models/product_real.dart';
import 'package:old_change_app/screens/detail_page/widgets/detail_app_bar.dart';
import 'package:old_change_app/screens/detail_page/widgets/product_info.dart';

class DetailScreen extends StatelessWidget {
  final Product item;
  const DetailScreen({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DetailAppBar(
              item: item,
            ),
            ProductInfo(
              item: item,
            ),
          ],
        ),
      ),
    );
  }
}
