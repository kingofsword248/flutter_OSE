// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:old_change_app/constants/colors.dart';
import 'package:old_change_app/models/category.dart';
import 'package:old_change_app/screens/category/widgets/fliter_list.dart';
import 'package:smart_select/smart_select.dart';

class RatingModalBottomSheet extends StatelessWidget {
  const RatingModalBottomSheet({
    Key key,
  }) : super(key: key);

  void close(context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    String content = "";
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(28),
        child: Wrap(
          alignment: WrapAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  alignment: Alignment.centerLeft,
                  child: InkWell(
                    child: Icon(Icons.close),
                    onTap: () {
                      close(context);
                    },
                  ),
                ),
                Text(
                  'Rating',
                  textAlign: TextAlign.center,
                ),
                Container(
                  width: 100,
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () {},
                    child: Text(
                      '',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 16,
                      ),
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                'Product Reviews',
                style: TextStyle(fontSize: 20),
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(top: 20),
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                alignment: WrapAlignment.center,
                children: [
                  RatingBar.builder(
                    initialRating: 3,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  ),
                  SizedBox(
                    height: 70,
                  ),
                  Form(
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      onSaved: (newValue) => content = newValue,
                      onChanged: (value) {
                        // if (value.isNotEmpty) {
                        //   removeError(error: kEmailNullError);
                        // } else if (emailValidatorRegExp.hasMatch(value)) {
                        //   removeError(error: kInvalidEmailError);
                        // }
                        // return null;
                      },
                      validator: (value) {
                        // if (value.isEmpty) {
                        //   addError(error: kEmailNullError);
                        //   return "";
                        // } else if (!emailValidatorRegExp.hasMatch(value)) {
                        //   addError(error: kInvalidEmailError);
                        //   return "";
                        // }
                        // return null;
                      },
                      decoration: InputDecoration(
                        labelText: "Content",
                        hintText: "Enter your Content",
                        // If  you are using latest version of flutter then lable text and hint text shown like this
                        // if you r using flutter less then 1.20.* then maybe this is not working properly
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 42, vertical: 20),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: primaryColor),
                            gapPadding: 10),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: primaryFocusColor),
                            gapPadding: 10),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(vertical: 20),
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7)),
                textColor: Colors.white,
                color: primaryColor,
                padding: EdgeInsets.all(20),
                child: Text(
                  'Submit',
                  style: TextStyle(fontSize: 16),
                ),
                onPressed: () {
                  close(context);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
