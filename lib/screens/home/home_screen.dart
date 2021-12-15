import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:old_change_app/models/input/cicle_screen1.dart';
import 'package:old_change_app/models/product_real.dart';
import 'package:old_change_app/models/trending.dart';
import 'package:old_change_app/models/user.dart';
import 'package:old_change_app/presenters/circle_home_presenter.dart';
import 'package:old_change_app/presenters/load_trending_presenter.dart';
import 'package:old_change_app/screens/circle_exchange/circle_card.dart';
import 'package:old_change_app/screens/delivery/delivery_screen.dart';
import 'package:old_change_app/utilities/fake.dart';
import 'package:old_change_app/models/category.dart';
import 'package:old_change_app/presenters/load_category_presenter.dart';
import 'package:old_change_app/screens/category/test/test.dart';
import 'package:old_change_app/screens/home/widgets/category_card.dart';
import 'package:old_change_app/screens/home/widgets/header.dart';
import 'package:old_change_app/screens/home/widgets/image_card.dart';
import 'package:old_change_app/screens/home/widgets/section.dart';
import 'package:old_change_app/utilities/colors.dart';
import 'package:old_change_app/widgets/app_bottom_navigation.dart';
import 'package:old_change_app/widgets/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    implements LoadCategoryContract, CircleHomeContrat, LoadTrendingContract {
  LoadCategoryPresenter _loadCategoryPresenter;
  CircleHomePresenter _circleHomePresenter;
  LoadTrendingPresenter _loadTrendingPresenter;
  List<CircleHome> circleList = [];
  List<Category> _list = [];
  List<Trending> _trending = [];
  User _a;
  bool __isLoading = true;
  bool _isTrending = true;
  List<Widget> ww = [
    const Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
      ),
    )
  ];
  @override
  void initState() {
    // TODO: implement initState
    _loadTrendingPresenter = LoadTrendingPresenter(this);
    _circleHomePresenter = CircleHomePresenter(this);
    _loadCategoryPresenter = LoadCategoryPresenter(this);
    _loadCategoryPresenter.onLoad();
    _loadTrendingPresenter.onLoad();
    getSharedPrefs().then((value) => {
          if (value)
            {
              if (_a.role == "shipper")
                {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => DeliveryScreen()),
                      (_) => false)
                }
              else
                _circleHomePresenter.onLoad(_a.token)
            }
        });
    super.initState();
  }

  @override
  void onLoadError(String onError) {
    Fake.showErrorDialog("No Internet", "An Error occur", context);
  }

  @override
  void onLoadSuccess(List<Category> list) {
    setState(() {
      __isLoading = false;
      _list = list;
    });
  }

  Future<bool> getSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String user = prefs.get('User');
    if (user != null) {
      setState(() {
        _a = User.fromJson(json.decode(user));
      });
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      bottomNavigationBar: const AppBottomNavigation(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Header(),
              __isLoading == true
                  ? Section("Categoty", ww)
                  : Section(
                      'Category',
                      _list.map((c) {
                        return CategoryCard(
                            title: c.brandname,
                            iconPath: c.brandname.contains("Laptop")
                                ? Fake.laptop
                                : Fake.phone,
                            onTap: () {
                              onCategoryOnSeleted(c.brandname, context,
                                  c.categories, c.idbrand);
                            });
                      }).toList()),
              _isTrending == true
                  ? Section("New Product", ww)
                  : Section(
                      'New Product',
                      _trending
                          .map((imagePath) => ImageCard(
                                item: imagePath,
                              ))
                          .toList()),
              circleList.isNotEmpty
                  ? Section(
                      'Recommended for you',
                      circleList
                          .map((imagePath) => CircleCard(
                                item: imagePath,
                              ))
                          .toList())
                  : Text(""),
            ],
          ),
        ),
      ),
    );
  }

  Widget cicrel() {
    return const Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
      ),
    );
  }

  onCategoryOnSeleted(
      String title, BuildContext context, List<Categories> list, int id) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Test(
                  title: title,
                  list: list,
                  brandID: id,
                )));
  }

  @override
  void onLoadCircleError(String error) {
    // TODO: implement onLoadCircleError
  }

  @override
  void onLoadCircleSuccess(List<CircleHome> list) {
    if (list != null)
      setState(() {
        circleList = list;
      });
  }

  @override
  void onTrendingError(String er) {
    // TODO: implement onTrendingError
  }

  @override
  void onTrendingSuccess(List<Trending> list) {
    setState(() {
      _trending = list;
      _isTrending = false;
    });
  }
}



// @override
// Widget build(BuildContext context) {
//   // SizeConfig().init(context);
  
// }
