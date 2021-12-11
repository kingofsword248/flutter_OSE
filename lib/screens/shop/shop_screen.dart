import 'package:flutter/material.dart';
import 'package:old_change_app/models/info.dart';

import 'package:old_change_app/models/product_real.dart';
import 'package:old_change_app/presenters/load_shop_presenter.dart';
import 'package:old_change_app/presenters/product_category_list_presentes.dart';
import 'package:old_change_app/screens/category/widgets/header_sliver.dart';
import 'package:old_change_app/screens/category/widgets/product_gird_item.dart';
import 'package:old_change_app/screens/detail_page/detail_page.dart';
import 'package:old_change_app/screens/shop/widgets/header_sliver.dart';
import 'package:old_change_app/utilities/colors.dart';
import 'package:old_change_app/utilities/fake.dart';
import 'package:old_change_app/widgets/app_bottom_navigation.dart';

class ShopScreen extends StatefulWidget {
  final String title;
  final int id;
  const ShopScreen({Key key, this.title, this.id}) : super(key: key);
  @override
  // ignore: no_logic_in_create_state
  _ShopScreenState createState() => _ShopScreenState(title);
}

class _ShopScreenState extends State<ShopScreen> implements LoadShopContract {
  final String title;

  Info _info;
  bool _isLoadingData = true;
  LoadShopPresenter _presenter;

  @override
  void initState() {
    super.initState();
    _presenter = LoadShopPresenter(this);
    _presenter.onLoad(widget.id);
  }

  _ShopScreenState(this.title);
  onProductSelected(int id) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DetailScreen(
                  productID: id,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: AppBottomNavigation(),
      backgroundColor: Colors.white,
      body: _isLoadingData
          ? Center(
              child: CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(primaryColor),
            ))
          : _info.listProduct.isEmpty
              ? OutlineButton(
                  child: Text("List is empty, Back"),
                  onPressed: () {
                    Navigator.pop(context);
                  })
              : CustomScrollView(
                  slivers: [
                    SliverPersistentHeader(
                      pinned: false,
                      floating: false,
                      delegate: HeaderSliver2(_info,
                          minExtent: 200, maxExtent: 200, content: title),
                    ),
                    SliverGrid.count(
                      crossAxisCount: 2,
                      childAspectRatio: 0.65,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      children: _info.listProduct.asMap().entries.map((f) {
                        return InkWell(
                          onTap: () {
                            onProductSelected(f.value.idProduct);
                          },
                          child: ProductGirdItem(
                              item: f.value,
                              margin: EdgeInsets.only(
                                  left: f.key.isEven ? 16 : 0,
                                  right: f.key.isOdd ? 16 : 0)),
                        );
                      }).toList(),
                    )
                  ],
                ),
    );
  }

  @override
  void onShopEr(String er) {
    Fake.showErrorDialog(er, "Error", context);
  }

  @override
  void onShopSuccess(Info info) {
    setState(() {
      _info = info;
      _isLoadingData = false;
    });
  }

  // Widget buildBody() {
  //   if (isLoadingData) {
  //     return Center(
  //       child: new CircularProgressIndicator(
  //         valueColor: new AlwaysStoppedAnimation<Color>(Colors.black),
  //       ),
  //     );
  //   }

  // }
}
