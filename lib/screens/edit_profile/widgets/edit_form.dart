import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:old_change_app/constants/colors.dart';
import 'package:old_change_app/data/fake.dart';
import 'package:old_change_app/models/input/post_image_result.dart';
import 'package:old_change_app/models/input/sign_up_form.dart';
import 'package:old_change_app/models/user.dart';
import 'package:old_change_app/presenters/load_image_presenter.dart';
import 'package:old_change_app/presenters/sign_up_presenter.dart';
import 'package:old_change_app/screens/cart/widgets/default_button.dart';

import 'package:old_change_app/widgets/form_error.dart';
import 'package:old_change_app/widgets/size_config.dart';
import 'package:smart_select/smart_select.dart';

class EditUpForm extends StatefulWidget {
  final Userr user;

  const EditUpForm({Key key, this.user}) : super(key: key);
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<EditUpForm> implements LoadImageContract {
  //LoadImage
  LoadImagePresenter _loadImagePresenter;
  var _isLoading = false;
  //signUp

  final _formKey = GlobalKey<FormState>();
  String username;
  String password;
  String conform_password;
  String phone;
  String address;
  String avatar;
  String avatar2;
  String fullname;
  String gender = "male";
  bool remember = false;
  // String date;
  // TextEditingController _dateController = TextEditingController();
  DateTime selectedDate;
  final List<String> errors = [];

  @override
  void initState() {
    fullname = widget.user.fullName;
    phone = widget.user.phone;
    address = widget.user.address;
    avatar2 = widget.user.avatar;

    // TODO: implement initState
    super.initState();
    _loadImagePresenter = LoadImagePresenter(this);

    // setState(() {
    //   selectedDate = DateTime.now();
    // });
  }

  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading == true
        ? CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(primaryColor),
          )
        : Form(
            key: _formKey,
            child: Column(
              children: [
                buildAvatar(),
                SizedBox(height: getProportionateScreenHeight(30)),
                buildFullNameFormField(),
                SizedBox(height: getProportionateScreenHeight(30)),
                buildAddressFormField(),
                SizedBox(height: getProportionateScreenHeight(30)),
                buildPhoneFormField(),
                SizedBox(height: getProportionateScreenHeight(10)),
                FormError(errors: errors),
                SizedBox(height: getProportionateScreenHeight(30)),
                DefaultButton(
                  text: "Save",
                  press: () {
                    if (avatar == null) {
                      addError(error: pPictures);
                    }
                    if (selectedDate == null) {
                      addError(error: pYOBNullError);
                    }
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      if (errors.isNotEmpty) {
                        return;
                      }
                      _loadImagePresenter.loadImage(File(avatar));
                      setState(() {
                        _isLoading = true;
                      });
                      // if all are valid then go to success screen
                    }
                  },
                ),
              ],
            ),
          );
  }

  SizedBox buildAvatar() {
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          CircleAvatar(
            backgroundImage: avatar != null
                ? FileImage(File(avatar))
                : NetworkImage(avatar2),
          ),
          Positioned(
            right: -16,
            bottom: 0,
            child: SizedBox(
              height: 46,
              width: 46,
              child: TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: BorderSide(color: Colors.white),
                  ),
                  primary: Colors.white,
                  backgroundColor: Color(0xFFF5F6F9),
                ),
                onPressed: () async {
                  final image = await ImagePicker()
                      .pickImage(imageQuality: 50, source: ImageSource.gallery);
                  setState(() {
                    avatar = image.path;
                  });
                  removeError(error: pPictures);
                },
                child: SvgPicture.asset("assets/icons/Camera Icon.svg"),
              ),
            ),
          ),
        ],
      ),
    );
  }

  TextFormField buildFullNameFormField() {
    return TextFormField(
      initialValue: fullname,
      onSaved: (newValue) => fullname = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: pNameNullError);
        }

        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: pNameNullError);
          return "";
        }

        return null;
      },
      decoration: InputDecoration(
        labelText: "Full Name",
        hintText: "Enter your Full Name",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: EdgeInsets.symmetric(horizontal: 42, vertical: 20),
        enabledBorder: ui(),
        focusedBorder: ui(),
      ),
    );
  }

  TextFormField buildAddressFormField() {
    return TextFormField(
      initialValue: address,
      onSaved: (newValue) => address = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kAddressNullError);
        }

        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kAddressNullError);
          return "";
        }

        return null;
      },
      decoration: InputDecoration(
        labelText: "Address",
        hintText: "Enter your Address",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: EdgeInsets.symmetric(horizontal: 42, vertical: 20),
        enabledBorder: ui(),
        focusedBorder: ui(),
      ),
    );
  }

  TextFormField buildPhoneFormField() {
    return TextFormField(
      initialValue: phone,
      onSaved: (newValue) => phone = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPhoneNumberNullError);
        }
        if (phoneValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidPhoneError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPhoneNumberNullError);
          return "";
        }
        if (!phoneValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidPhoneError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Phone",
        hintText: "Enter your Phone",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: EdgeInsets.symmetric(horizontal: 42, vertical: 20),
        enabledBorder: ui(),
        focusedBorder: ui(),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1930, 8),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
      removeError(error: pYOBNullError);
    }
  }

  OutlineInputBorder ui() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(28),
        borderSide: BorderSide(color: primaryColor),
        gapPadding: 10);
  }

  @override
  void onLoadImageComplete(ImageResult result) {
    // String dob =
    //     "${selectedDate.toLocal().year}/${selectedDate.toLocal().month}/${selectedDate.toLocal().day}";
    // SignUpFormDTO dto = SignUpFormDTO(
    //     userName: username,
    //     address: address,
    //     avatar: result.url,
    //     fullName: fullname,
    //     gender: gender,
    //     password: password,
    //     phone: phone,
    //     dob: dob);
    // _signUpPresenter.register(dto);
  }

  @override
  void onLoadImageError(String error) {
    Fake.showErrorDialog(
        "Can not upload photos", "An error has occurred", context);
    setState(() {
      _isLoading = false;
    });
  }
}
