import 'package:flutter/material.dart';
import 'package:old_change_app/models/user.dart';
import 'package:old_change_app/screens/edit_profile/widgets/body.dart';

class EditScreen extends StatelessWidget {
  final User user;

  const EditScreen({Key key, this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          "Edit Profile",
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            if (Navigator.canPop(context)) Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Body(
        user: user,
      ),
    );
  }
}
