import 'dart:async';

import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:old_change_app/models/category.dart';
import 'package:old_change_app/models/product_real.dart';
import 'package:old_change_app/presenters/product_category_list_presentes.dart';
import 'package:old_change_app/screens/category/test/sliver_grid_bloc.dart';
import 'package:old_change_app/screens/category/widgets/header_sliver.dart';
import 'package:old_change_app/screens/category/widgets/product_gird_item.dart';
import 'package:old_change_app/screens/detail_page/detail_page.dart';
import 'package:old_change_app/widgets/app_bottom_navigation.dart';

class Test extends StatefulWidget {
  final String title;
  final List<Categories> list;
  const Test({Key key, this.title, this.list}) : super(key: key);
  @override
  // ignore: no_logic_in_create_state
  _TestState createState() => _TestState(title);
}

class _TestState extends State<Test> implements ProductListViewContrat {
  final String title;
  ProductListPresenters _listPresenters;
  List<Product> products = [];
  bool _isLoadingData = false;
  String input = '1';

  // test
  final PagingController<int, Product> _pagingController =
      PagingController(firstPageKey: 0);
  StreamSubscription _blocListingStateSubscription;
  final CharacterSliverGridBloc _bloc = CharacterSliverGridBloc();

  @override
  void initState() {
    // if (title == 'Clothes') {
    //   input = '2';
    // } else if (title == 'Phone') {
    //   input = '3';
    // } else if (title == 'Laptop') {
    //   input = '4';
    // }
    // _listPresenters = new ProductListPresenters(this);
    // _listPresenters.loadProduct(input);

    _pagingController.addPageRequestListener((pageKey) {
      _bloc.onPageRequestSink.add(pageKey);
    });

    // We could've used StreamBuilder, but that would unnecessarily recreate
    // the entire [PagedSliverGrid] every time the state changes.
    // Instead, handling the subscription ourselves and updating only the
    // _pagingController is more efficient.
    _blocListingStateSubscription =
        _bloc.onNewListingState.listen((listingState) {
      _pagingController.value = PagingState(
        nextPageKey: listingState.nextPageKey,
        error: listingState.error,
        itemList: listingState.itemList,
      );
    });
    super.initState();
  }

  _TestState(this.title);
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
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              pinned: true,
              floating: true,
              delegate: HeaderSliver(
                  minExtent: 60,
                  maxExtent: 60,
                  content: title,
                  list: widget.list),
            ),
            // SliverGrid.count(
            //   crossAxisCount: 2,
            //   childAspectRatio: 0.65,
            //   mainAxisSpacing: 16,
            //   crossAxisSpacing: 16,
            //   children: products.asMap().entries.map((f) {
            //     return InkWell(
            //       onTap: () {
            //         onProductSelected(f.value);
            //       },
            //       child: ProductGirdItem(
            //           item: f.value,
            //           margin: EdgeInsets.only(
            //               left: f.key.isEven ? 16 : 0,
            //               right: f.key.isOdd ? 16 : 0)),
            //     );
            //   }).toList(),
            // ),
            PagedSliverGrid<int, Product>(
                pagingController: _pagingController,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 0.65,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  crossAxisCount: 2,
                ),
                builderDelegate: PagedChildBuilderDelegate<Product>(
                  itemBuilder: (context, item, index) => InkWell(
                    onTap: () {
                      onProductSelected(item.idProduct);
                    },
                    child: ProductGirdItem(
                        item: item,
                        margin: EdgeInsets.only(
                            left: index.isEven ? 16 : 0,
                            right: index.isOdd ? 16 : 0)),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    _blocListingStateSubscription.cancel();
    _bloc.dispose();
    super.dispose();
  }

  @override
  void onLoadProductComplete(List<Product> products) {
    setState(() {
      this.products = products;
      _isLoadingData = false;
    });
  }

  @override
  void onLoadProductError() {
    setState(() {
      _isLoadingData = false;
      products = [];
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
