import 'package:flutter/material.dart';
import 'package:old_change_app/data/fake.dart';
import 'package:old_change_app/models/product.dart';
import 'package:old_change_app/models/product_real.dart';
import 'package:old_change_app/presenters/product_category_list_presentes.dart';
import 'package:old_change_app/screens/category/widgets/header_sliver.dart';
import 'package:old_change_app/screens/category/widgets/product_gird_item.dart';
import 'package:old_change_app/screens/detail_page/detail_page.dart';
import 'package:old_change_app/screens/detail_page/detail_screen.dart';
import 'package:old_change_app/widgets/app_bottom_navigation.dart';

class CategoryScreen extends StatefulWidget {
  final String title;

  const CategoryScreen({Key key, this.title}) : super(key: key);
  @override
  // ignore: no_logic_in_create_state
  _CategoryScreenState createState() => _CategoryScreenState(title);
}

class _CategoryScreenState extends State<CategoryScreen>
    implements ProductListViewContrat {
  final String title;
  ProductListPresenters _listPresenters;
  List<Product> products = [];
  bool isLoadingData = true;
  String input = '1';

  @override
  void initState() {
    if (title == 'Clothes') {
      input = '2';
    } else if (title == 'Phone') {
      input = '3';
    } else if (title == 'Laptop') {
      input = '4';
    }
    _listPresenters = new ProductListPresenters(this);
    _listPresenters.loadProduct(input);
  }

  _CategoryScreenState(this.title);
  onProductSelected(product) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => DetailScreen(item: product)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: AppBottomNavigation(),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              pinned: true,
              floating: true,
              delegate:
                  HeaderSliver(minExtent: 60, maxExtent: 60, content: title),
            ),
            SliverGrid.count(
              crossAxisCount: 2,
              childAspectRatio: 0.65,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              children: products.asMap().entries.map((f) {
                return InkWell(
                  onTap: () {
                    onProductSelected(f.value);
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
      ),
    );
  }

  @override
  void onLoadProductComplete(List<Product> products) {
    setState(() {
      this.products = products;
      isLoadingData = false;
    });
  }

  @override
  void onLoadProductError() {
    isLoadingData = false;
    products = [];
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
