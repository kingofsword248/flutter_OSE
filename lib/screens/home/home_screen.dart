import 'package:flutter/material.dart';
import 'package:old_change_app/data/fake.dart';

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

class _HomeScreenState extends State<HomeScreen> {
  onCategoryOnSeleted(String title) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Test(
                  title: title,
                )));
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
              Section(
                  'Category',
                  Fake.categories.map((c) {
                    return CategoryCard(
                        title: c.title,
                        iconPath: c.iconPath,
                        onTap: () {
                          onCategoryOnSeleted(c.title);
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
}
