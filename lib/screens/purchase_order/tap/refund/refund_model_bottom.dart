// ignore_for_file: prefer_const_constructors
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:old_change_app/models/input/feedback_request.dart';
import 'package:old_change_app/presenters/send_request_presenter.dart';
import 'package:old_change_app/utilities/fake.dart';
import 'package:old_change_app/models/input/post_image_result.dart';
import 'package:old_change_app/models/input/product_form.dart';
import 'package:old_change_app/models/input/reviews_form.dart';
import 'package:old_change_app/models/user.dart';
import 'package:old_change_app/presenters/load_image_presenter.dart';
import 'package:old_change_app/presenters/post_review.dart';
import 'package:old_change_app/screens/sign_in/sign_in_screen.dart';
import 'package:old_change_app/utilities/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RefundModalBottomSheet extends StatefulWidget {
  final int idOrderDetail;

  RefundModalBottomSheet({
    Key key,
    this.idOrderDetail,
  }) : super(key: key);

  @override
  State<RefundModalBottomSheet> createState() => _RefundModalBottomSheetState();
}

class _RefundModalBottomSheetState extends State<RefundModalBottomSheet>
    implements LoadImageContract, SendRefundRequestContract {
  void close(context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }

  SendRefundPresenter _refundPresenter;
  LoadImagePresenter _imagePresenter;

  //hinh
  List<XFile> _files = [];
  bool isLoading = false;
  List<ImageP> imageList = [];

  final _formKey = GlobalKey<FormState>();
  String reason;

  User _a;

  @override
  void initState() {
    // TODO: implement initState
    _refundPresenter = SendRefundPresenter(this);
    _imagePresenter = LoadImagePresenter(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                  'Refund',
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
                'Please tell us the reason for the return',
                style: TextStyle(fontSize: 20),
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(top: 20),
              child: isLoading == true
                  ? CircularProgressIndicator()
                  : Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      alignment: WrapAlignment.center,
                      children: [
                        contentForm(),
                        SizedBox(
                          height: 70,
                        ),
                        imageWidgets()
                      ],
                    ),
            ),
            if (isLoading == false) submitButtom(context)
          ],
        ),
      ),
    );
  }

  Widget submitButtom(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 20),
      child: RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
        textColor: Colors.white,
        color: primaryColor,
        padding: EdgeInsets.all(20),
        child: Text(
          'Submit',
          style: TextStyle(fontSize: 16),
        ),
        onPressed: () {
          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();

            if (_files.isNotEmpty) {
              setState(() {
                isLoading = true;
              });
              for (var i = 0; i < _files.length; i++) {
                _imagePresenter.loadImage(File(_files[i].path));
              }
            } else {
              // print("submit ko hinh step1");
              Fake.showErrorDialog("Request image", "Error", context);
            }
          }

          // close(context);
        },
      ),
    );
  }

  Future<Null> getSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String user = prefs.get('User');

    setState(() {
      _a = User.fromJson(json.decode(user));
    });
  }

  Widget contentForm() {
    return Form(
      key: _formKey,
      child: TextFormField(
        maxLines: 4,
        keyboardType: TextInputType.text,
        onSaved: (newValue) => reason = newValue,
        onChanged: (value) {
          // if (value.isNotEmpty) {
          //   removeError(error: kEmailNullError);
          // } else if (emailValidatorRegExp.hasMatch(value)) {
          //   removeError(error: kInvalidEmailError);
          // }
          // return null;
        },
        validator: (value) {
          if (value.isEmpty) {
            return "Content is empty";
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: "Reason",
          hintText: "Enter your Content",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          contentPadding: EdgeInsets.symmetric(horizontal: 42, vertical: 20),
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
    );
  }

  Widget imageWidgets() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text("Choice image"),
            Container(
              child: Wrap(
                children: [
                  RaisedButton(
                      child: Text(
                        "Choice",
                        style: TextStyle(
                            color: primaryColor, fontWeight: FontWeight.w600),
                      ),
                      onPressed: () {
                        pickImage();
                      }),
                  SizedBox(
                    width: 5,
                  ),
                  RaisedButton(
                      child: Text(
                        "Reset",
                        style: TextStyle(
                            color: primaryColor, fontWeight: FontWeight.w600),
                      ),
                      onPressed: () {
                        setState(() {
                          _files.clear();
                          imageList.clear();
                        });
                      }),
                ],
              ),
            )
          ],
        ),
        // _files.isEmpty
        //     ? Text("Upload your Image (Maximun is 3)")
        //     : Wrap(
        //         children: [
        //           if (uploadImageLoading == false)
        //             OutlineButton(
        //                 child: Text(
        //                   "Load Image to Server",
        //                   style: TextStyle(color: primaryColor),
        //                 ),
        //                 onPressed: () {}),
        //           if (uploadImageLoading)
        //             Text("Loading... (${imageList.length}/${_files.length})")
        //         ],
        //       ),
        _files.isEmpty
            ? const Text("")
            : GridView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemCount: _files.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.file(
                      File(_files[index].path),
                      // height: 100,
                      fit: BoxFit.cover,
                    ),
                  );
                }),
      ],
    );
  }

  Future pickImage() async {
    final image = await ImagePicker().pickMultiImage(imageQuality: 50);
    // if (image == null) return;
    if (image.length >= 4) {
      Fake.showErrorDialog("Maximun is 3", "Notification", context);
      return;
    }
    setState(() {
      _files = image;
      imageList.clear();
    });
    try {} on PlatformException catch (e) {
      // print(e.toString());
    }
  }

  @override
  void onLoadImageComplete(ImageResult result) {
    setState(() {
      imageList.add(ImageP(url: result.url));
      if (imageList.length == _files.length) {
        FeedbackRequest request = FeedbackRequest(
            idOrderDetail: widget.idOrderDetail,
            reason: reason,
            image: imageList);
        _refundPresenter.onSend(request);
      }
    });
  }

  @override
  Future<void> onLoadImageError(String error) async {
    Fake.showErrorDialog(error, "Notification Error", context);

    if (error.contains("Unauthorized")) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.clear();
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SignInScreen()));
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Future<void> onSendError(String error) async {
    if (error.contains("Unauthorized")) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.clear();
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SignInScreen()));
      return;
    }
    Fake.showErrorDialog(error, "Notification Error", context);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void onSendSuccess(bool success) {
    if (success) {
      Fake.showDiaglog(context, "Success");
      close(context);
    } else {
      Fake.showDiaglog(context, "Failed");
      setState(() {
        isLoading = false;
      });
    }
  }
}
