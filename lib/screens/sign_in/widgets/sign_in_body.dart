import 'package:flutter/material.dart';
import 'package:old_change_app/screens/sign_in/widgets/no_account_text.dart';
import 'package:old_change_app/screens/sign_in/widgets/sign_in_form.dart';
import 'package:old_change_app/widgets/size_config.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.04),
                Text(
                  "Login",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: getProportionateScreenWidth(45),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Sign in with your email and password  \nor continue with social media",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.08),
                SignForm(),
                SizedBox(height: SizeConfig.screenHeight * 0.08),
                SizedBox(height: getProportionateScreenHeight(16)),
                NoAccountText(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
