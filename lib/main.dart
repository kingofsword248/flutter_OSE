import 'package:flutter/material.dart';
import 'package:old_change_app/models/providers/menu_bottom.dart';
import 'package:old_change_app/utilities/colors.dart';
import '../screens/home/home_screen.dart';
import 'package:provider/provider.dart';

import 'models/providers/cart_item.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: CartList()),
        ChangeNotifierProvider.value(value: MenuBottomDT())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Old change app",
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          primaryColor: primaryColor,
          splashColor: Colors.transparent,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
