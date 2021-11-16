import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:old_change_app/constants/colors.dart';
import 'package:old_change_app/data/fake.dart';
import 'package:old_change_app/models/input/post_image_result.dart';
import 'package:old_change_app/models/input/sign_up_form.dart';
import 'package:old_change_app/presenters/load_image_presenter.dart';
import 'package:old_change_app/presenters/sign_up_presenter.dart';
import 'package:old_change_app/screens/cart/widgets/default_button.dart';

import 'package:old_change_app/widgets/form_error.dart';
import 'package:old_change_app/widgets/size_config.dart';
import 'package:smart_select/smart_select.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm>
    implements LoadImageContract, SignUpContract {
  //LoadImage
  LoadImagePresenter _loadImagePresenter;
  var _isLoading = false;
  //signUp
  SignUpPresenter _signUpPresenter;
  final _formKey = GlobalKey<FormState>();
  String username;
  String password;
  String conform_password;
  String phone;
  String address;
  String avatar;
  String fullname;
  String gender = "male";
  bool remember = false;
  String date;
  // TextEditingController _dateController = TextEditingController();
  DateTime selectedDate;
  final List<String> errors = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadImagePresenter = LoadImagePresenter(this);
    _signUpPresenter = SignUpPresenter(this);
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
                buildEmailFormField(),
                SizedBox(height: getProportionateScreenHeight(30)),
                buildPasswordFormField(),
                SizedBox(height: getProportionateScreenHeight(30)),
                buildConformPassFormField(),
                SizedBox(height: getProportionateScreenHeight(30)),
                buildFullNameFormField(),
                SizedBox(height: getProportionateScreenHeight(30)),
                buildAddressFormField(),
                SizedBox(height: getProportionateScreenHeight(30)),
                buildPhoneFormField(),
                SizedBox(height: getProportionateScreenHeight(30)),
                genderForm(),
                yobForm(),
                FormError(errors: errors),
                SizedBox(height: getProportionateScreenHeight(40)),
                DefaultButton(
                  text: "Continue",
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

  SmartSelect genderForm() {
    List<S2Choice<String>> options = [
      S2Choice<String>(value: 'male', title: 'Male'),
      S2Choice<String>(value: 'female', title: 'Female'),
    ];
    return SmartSelect.single(
        title: "Gender",
        value: gender,
        onChange: (state) {
          setState(() {
            gender = state.value;
          });
        },
        choiceItems: options,
        modalType: S2ModalType.popupDialog);
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
                : AssetImage("assets/images/user.png"),
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

  TextFormField buildConformPassFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => conform_password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        }
        if (value.isNotEmpty && value == password) {
          removeError(error: kMatchPassError);
        }
        conform_password = value;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if ((password != value)) {
          addError(error: kMatchPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Confirm Password",
        hintText: "Re-enter your password",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: EdgeInsets.symmetric(horizontal: 42, vertical: 20),
        enabledBorder: ui(),
        focusedBorder: ui(),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        password = value;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 8) {
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Enter your password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: EdgeInsets.symmetric(horizontal: 42, vertical: 20),
        enabledBorder: ui(),
        focusedBorder: ui(),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      onSaved: (newValue) => username = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        }
        if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        }
        if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Username",
        hintText: "Enter your Username",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: EdgeInsets.symmetric(horizontal: 42, vertical: 20),
        enabledBorder: ui(),
        focusedBorder: ui(),
      ),
    );
  }

  TextFormField buildFullNameFormField() {
    return TextFormField(
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

  Widget yobForm() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 17),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          selectedDate != null
              ? Text(
                  "Dob : " + "${selectedDate.toLocal()}".split(' ')[0],
                  style: const TextStyle(fontSize: 16),
                )
              : Text("Date of birth"),
          FlatButton(
            onPressed: () => _selectDate(context),
            child: Text(
              "Select date",
            ),
            textColor: primaryColor,
          )
        ],
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
    String dob =
        "${selectedDate.toLocal().year}/${selectedDate.toLocal().month}/${selectedDate.toLocal().day}";
    SignUpFormDTO dto = SignUpFormDTO(
        userName: username,
        address: address,
        avatar: result.url,
        fullName: fullname,
        gender: gender,
        password: password,
        phone: phone,
        dob: dob);
    _signUpPresenter.register(dto);
  }

  @override
  void onLoadImageError(String error) {
    Fake.showErrorDialog(
        "Can not upload photos", "An error has occurred", context);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void onSignUpError(String error) {
    Fake.showErrorDialog(error, "An error has occurred ", context);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void onSignUpSuccess(bool isComplete) {
    if (isComplete) {
      Fake.showDiaglog(context, "Account successfully created");
      if (Navigator.canPop(context)) Navigator.pop(context);
    }
  }
}
