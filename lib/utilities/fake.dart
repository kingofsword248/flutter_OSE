import 'package:flutter/material.dart';
import 'package:old_change_app/models/category.dart';
import 'package:old_change_app/models/item.dart';

import 'package:old_change_app/models/product_real.dart';
import 'package:old_change_app/models/user.dart';

class Fake {
  static int numberOfItemsInCart = 2;
  static int selectedIndex = 0;
  static String phone = "assets/icons/phone-svgrepo-com.svg";
  static String laptop = "assets/icons/laptop-svgrepo-com.svg";
  static List<Category2> categories = [
    Category2('assets/icons/desktop-computer-svgrepo-com.svg', 'Computer'),
    Category2('assets/icons/clothes-svgrepo-com.svg', 'Clothes'),
    Category2('assets/icons/phone-svgrepo-com.svg', 'Phone'),
    Category2('assets/icons/laptop-svgrepo-com.svg', 'Laptop'),
  ];
  static List<String> trending = [
    'assets/images/furniture/jacalyn-beales-435629-unsplash.png',
    'assets/images/furniture/sven-brandsma-1379481-unsplash.png',
  ];
  static List<String> featured = [
    'assets/images/furniture/pexels-eric-montanah-1350789.jpg',
    'assets/images/furniture/pexels-patryk-kamenczak-775219.jpg',
    'assets/images/furniture/pexels-pixabay-276534.jpg',
    'assets/images/furniture/pexels-steve-johnson-923192.jpg'
  ];
  static List<Item> product = [
    Item(
      name: 'Chair Dacey li - Black',
      imagePath: 'assets/images/furniture/items/dacey.png',
      originalPrice: 80,
      rating: 4.5,
      discountPercent: 30,
    ),
    Item(
      name: 'Người yêu',
      imagePath: 'assets/images/furniture/items/thuan.jpg',
      originalPrice: 140,
      rating: 4.4,
      discountPercent: 30,
    ),
    Item(
      name: 'Dobson Table - White',
      imagePath: 'assets/images/furniture/items/table 2.png',
      originalPrice: 160,
      rating: 4.3,
      discountPercent: 25,
    ),
    Item(
      name: 'Nagano Table - Brown',
      imagePath: 'assets/images/furniture/items/ezgif.com-crop.png',
      originalPrice: 140,
      rating: 4.3,
      discountPercent: 20,
    ),
    Item(
      name: 'Chair Dacey li - White',
      imagePath: 'assets/images/furniture/items/CHair 2.png',
      originalPrice: 80,
      rating: 4.3,
      discountPercent: 20,
    ),
    Item(
      name: 'Chair Dacey li - Feather Grey',
      imagePath: 'assets/images/furniture/items/chair3.png',
      originalPrice: 80,
      rating: 4.0,
      discountPercent: 20,
    ),
  ];
  static List<Product> product2 = [
    Product(
        idProduct: 1,
        name: 'MacBook Air  ',
        description:
            'Khám phá nào đã làm bối rối những bộ óc khoa học vĩ đại nhất của thế kỷ qua, và tại sao nó lại khiến họ phải suy nghĩ lại về nguồn gốc vũ trụ của chúng ta?',
        price: 80,
        quantity: 1,
        images: [
          Images(address: 'assets/images/furniture/items/laptop.png'),
          Images(address: 'assets/images/furniture/items/laptop2.png'),
        ]),
    Product(
        idProduct: 2,
        name: 'Mac Book Air 13.3 inches M1 Chipset ',
        description:
            'Khám phá nào đã làm bối rối những bộ óc khoa học vĩ đại nhất của thế kỷ qua, và tại sao nó lại khiến họ phải suy nghĩ lại về nguồn gốc vũ trụ của chúng ta?',
        price: 80,
        quantity: 1,
        images: [
          Images(address: 'assets/images/furniture/items/laptop.png'),
          Images(address: 'assets/images/furniture/items/laptop2.png'),
        ]),
    Product(
        idProduct: 3,
        name: 'Mac Book Air 13.3 inches M1 Chipset ',
        description:
            'Khám phá nào đã làm bối rối những bộ óc khoa học vĩ đại nhất của thế kỷ qua, và tại sao nó lại khiến họ phải suy nghĩ lại về nguồn gốc vũ trụ của chúng ta?',
        price: 80,
        quantity: 1,
        images: [
          Images(address: 'assets/images/furniture/items/laptop.png'),
          Images(address: 'assets/images/furniture/items/laptop2.png'),
        ]),
  ];
  static List<User> listuser = [];
  static void showDiaglog(BuildContext context, String mess) {
    final snackbar = SnackBar(content: Text(mess));
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  static String status = "BOTH";
  static List<Map<String, dynamic>> categoryFake = [];
  static void showErrorDialog(
      String message, String title, BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }
}
