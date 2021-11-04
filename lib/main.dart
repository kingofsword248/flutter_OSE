import 'package:flutter/material.dart';
import '../screens/home/home_screen.dart';
import 'package:provider/provider.dart';
import "constants/colors.dart";
import 'models/cart_item.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider.value(value: CartList())],
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
