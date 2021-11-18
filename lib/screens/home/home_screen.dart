import 'package:flutter/material.dart';
import 'package:old_change_app/constants/colors.dart';
import 'package:old_change_app/data/fake.dart';
import 'package:old_change_app/models/category.dart';
import 'package:old_change_app/presenters/load_category_presenter.dart';

import 'package:old_change_app/screens/category/category_screens.dart';
import 'package:old_change_app/screens/category/test/test.dart';

import 'package:old_change_app/screens/home/widgets/category_card.dart';
import 'package:old_change_app/screens/home/widgets/header.dart';
import 'package:old_change_app/screens/home/widgets/image_card.dart';
import 'package:old_change_app/screens/home/widgets/section.dart';
import 'package:old_change_app/widgets/app_bottom_navigation.dart';
import 'package:old_change_app/widgets/size_config.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    implements LoadCategoryContract {
  LoadCategoryPresenter _loadCategoryPresenter;
  List<Category> _list = [];
  bool __isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    _loadCategoryPresenter = LoadCategoryPresenter(this);
    _loadCategoryPresenter.onLoad();
    super.initState();
  }

  @override
  void onLoadError(String onError) {
    Fake.showErrorDialog("No Internet", "An Error occur", context);
    _loadCategoryPresenter.onLoad();
  }

  @override
  void onLoadSuccess(List<Category> list) {
    setState(() {
      __isLoading = false;
      _list = list;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      bottomNavigationBar: const AppBottomNavigation(),
      body: SafeArea(
        child: __isLoading == true
            ? const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Header(),
                    Section(
                        'Category',
                        _list.map((c) {
                          return CategoryCard(
                              title: c.brandname,
                              iconPath: c.brandname.contains("Laptop")
                                  ? Fake.laptop
                                  : Fake.phone,
                              onTap: () {
                                onCategoryOnSeleted(
                                    c.brandname, context, c.categories);
                              });
                        }).toList()),
                    Section(
                        'Trending',
                        Fake.product2
                            .map((imagePath) => ImageCard(
                                  item: imagePath,
                                ))
                            .toList()),
                    Section(
                        'Recommended for you',
                        Fake.product2
                            .map((imagePath) => ImageCard(
                                  item: imagePath,
                                ))
                            .toList()),
                  ],
                ),
              ),
      ),
    );
  }

  onCategoryOnSeleted(
      String title, BuildContext context, List<Categories> list) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Test(
                  title: title,
                  list: list,
                )));
  }
}



// @override
// Widget build(BuildContext context) {
//   // SizeConfig().init(context);
  
// }
