import 'package:flutter/material.dart';
import 'package:old_change_app/models/user.dart';
import 'package:old_change_app/screens/edit_profile/widgets/edit_form.dart';
import 'package:old_change_app/widgets/size_config.dart';

class Body extends StatelessWidget {
  final Userr user;

  const Body({Key key, this.user}) : super(key: key);
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
                // SizedBox(height: SizeConfig.screenHeight * 0.03), // 4%

                SizedBox(height: SizeConfig.screenHeight * 0.04),
                EditUpForm(
                  user: user,
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.08),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
