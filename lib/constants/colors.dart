import 'package:flutter/material.dart';

const Color primaryColor = Color.fromRGBO(70, 100, 138, 1);
const Color primaryFocusColor = Color(0xFF3150B4);
const Color primaryPromoColor = Color(0xFF3150B4);
const Color secondaryPromoColor = Color(0xFF0F2C91);
const Color tagBackgroundColor = Color.fromRGBO(177, 173, 173, 0.25);

final RegExp emailValidatorRegExp = RegExp(r"^[a-zA-Z0-9.]+");
const String kEmailNullError = "Please Enter your email";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String kNamelNullError = "Please Enter your name";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kAddressNullError = "Please Enter your address";

const String pNameNullError = "Please Enter Name";
const String pDesNullError = "Please Enter Description";
const String pQuantityNullError = "Please Enter Quantity";
const String pQuantityIFError = "Quantity must greater than 0";
const String pPriceNullError = "Please Enter Price";
const String pPriceIFError = "Price must greater than 0";
const String pPictures = "Request pictures";
const String pCategoryError = "Request Category";
const String pCategoryTrade = "Request type of product, you want to change";
