import 'package:flutter/material.dart';
import 'package:old_change_app/screens/sign_up/sign_up_screen.dart';
import 'package:old_change_app/utilities/colors.dart';
import 'package:old_change_app/widgets/size_config.dart';

class NoAccountText extends StatelessWidget {
  const NoAccountText({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don’t have an account? ",
          style: TextStyle(fontSize: getProportionateScreenWidth(16)),
        ),
        GestureDetector(
          onTap: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => SignUpScreen())),
          child: Text(
            "Sign Up",
            style: TextStyle(
                fontSize: getProportionateScreenWidth(16), color: primaryColor),
          ),
        ),
      ],
    );
  }
}
