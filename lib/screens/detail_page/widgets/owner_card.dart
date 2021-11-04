import 'package:flutter/material.dart';
import 'package:old_change_app/constants/colors.dart';
import 'package:old_change_app/models/user.dart';

class CardOwner extends StatelessWidget {
  final User user;
  const CardOwner({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 100,
        color: Colors.white,
        child: Row(
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Image.asset("assets/images/avatar.png"),
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.topLeft,
                child: Column(
                  children: [
                    Expanded(
                      flex: 5,
                      child: ListTile(
                        title: Text("Shape Of You"),
                        subtitle: Text("Phone : 0192491248"),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            child: Text(
                              "View Shop",
                              style: TextStyle(color: primaryColor),
                            ),
                            onPressed: () {},
                          ),
                          SizedBox(
                            width: 8,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              flex: 8,
            ),
          ],
        ),
      ),
      elevation: 6,
      shadowColor: Colors.black.withOpacity(0.7),
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.white)),
    );
  }
}
