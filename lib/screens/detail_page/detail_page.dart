import 'package:flutter/material.dart';
import 'package:old_change_app/models/input/product_detail.dart';

import 'package:old_change_app/models/product_real.dart';
import 'package:old_change_app/presenters/load_detail.dart';
import 'package:old_change_app/screens/detail_page/widgets/detail_app_bar.dart';
import 'package:old_change_app/screens/detail_page/widgets/product_info.dart';

class DetailScreen extends StatefulWidget {
  // final Product item;
  final int productID;
  const DetailScreen({Key key, this.productID}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen>
    implements LoadProductDetailContract {
  bool isLoading = true;
  LoadProductDetailPresenter _presenter;
  ProductDetail product;
  String errorw;
  bool isError = false;

  @override
  void initState() {
    _presenter = LoadProductDetailPresenter(this);
    // TODO: implement initState
    super.initState();
    _presenter.onLoad(widget.productID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: isLoading == true
            ? const Center(child: CircularProgressIndicator())
            : isError
                ? Text(errorw)
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DetailAppBar(
                          item: product,
                        ),
                        ProductInfo(
                          item: product,
                        ),
                      ],
                    ),
                  ),
      ),
    );
  }

  @override
  void onLoadDetailError(String error) {
    setState(() {
      errorw = error;
      isLoading = false;
      isError = true;
    });
  }

  @override
  void onLoadDetailSuccess(ProductDetail item) {
    setState(() {
      product = item;
      isLoading = false;
    });
  }
}
