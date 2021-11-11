import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:old_change_app/constants/colors.dart';
import 'package:old_change_app/data/fake.dart';
import 'package:old_change_app/models/input/category_request.dart';
import 'package:old_change_app/models/input/post_image_result.dart';
import 'package:old_change_app/presenters/categories_presenter.dart';
import 'package:old_change_app/presenters/load_image_presenter.dart';
import 'package:old_change_app/screens/cart/widgets/default_button.dart';
import 'package:old_change_app/widgets/size_config.dart';
import 'package:smart_select/smart_select.dart';

class Body extends StatefulWidget {
  const Body({Key key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body>
    implements CategoryContract, LoadImageContract {
  //catefory
  CategoryPresenter _categoryPresenter;
  List<CategoryRequest> listCategories;
  // List<Map<String, dynamic>> data;
  var _isLoading = false;
  //load image
  List<XFile> _files = [];

  List<ImageResult> imageResultList = [];
  LoadImagePresenter _imagePresenter;
  //form
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _categoryPresenter = CategoryPresenter(this);
    _imagePresenter = LoadImagePresenter(this);
    if (Fake.categoryFake.isEmpty) {
      // setState(() {
      //   _isLoading = true;
      // });
      // _categoryPresenter.loadCategory();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: _isLoading
          ? Center(
              child: CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(primaryColor),
            ))
          : Container(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                child: SingleChildScrollView(
                    child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      nameForm(),
                      const SizedBox(
                        height: 20,
                      ),
                      descriptionForm(),
                      const SizedBox(
                        height: 20,
                      ),
                      quantityForm(),
                      const SizedBox(
                        height: 20,
                      ),
                      priceForm(),
                      const SizedBox(
                        height: 20,
                      ),
                      statusForm(),
                      const SizedBox(
                        height: 20,
                      ),
                      if (Fake.categoryFake.isNotEmpty) categoryForm(),
                      imageWidgets(),
                      DefaultButton(
                        text: "Post Product",
                        press: () {
                          if (_files == null) return;
                          for (var i = 0; i < _files.length; i++) {
                            _imagePresenter.loadImage(File(_files[i].path));
                          }
                          // if (_formKey.currentState.validate()) {
                          //   _formKey.currentState.save();

                          //   setState(() {
                          //     // _isLoading = true;
                          //     // _loginPresenter.login(LoginForm(
                          //     //     userName: email, password: password));
                          //   });
                          //   for (var i = 0; i < _files.length; i++) {
                          //     _imagePresenter.loadImage(File(_files[i].path));
                          //   }
                          //   // KeyboardUtil.hideKeyboard(context);

                          // }
                        },
                      ),
                    ],
                  ),
                )),
              ),
            ),
    );
  }

  Future pickImage() async {
    final image = await ImagePicker().pickMultiImage(imageQuality: 50);
    // if (image == null) return;
    setState(() {
      _files = image;
    });
    try {} on PlatformException catch (e) {
      print(e.toString());
    }
  }

  Widget imageWidgets() {
    return Column(
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
                        });
                      }),
                ],
              ),
            )
          ],
        ),
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

  TextFormField nameForm() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Name",
        hintText: "Enter name's product",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: EdgeInsets.symmetric(horizontal: 42, vertical: 20),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28),
            borderSide: BorderSide(color: primaryColor),
            gapPadding: 10),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28),
            borderSide: BorderSide(color: primaryFocusColor),
            gapPadding: 10),
      ),
    );
  }

  TextFormField descriptionForm() {
    return TextFormField(
      maxLines: null,
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
        labelText: "Description",
        hintText: "Enter description's product",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: EdgeInsets.symmetric(horizontal: 42, vertical: 20),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28),
            borderSide: BorderSide(color: primaryColor),
            gapPadding: 10),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28),
            borderSide: BorderSide(color: primaryFocusColor),
            gapPadding: 10),
      ),
    );
  }

  TextFormField quantityForm() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: "Quantity",
        hintText: "Enter quantity's product",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: EdgeInsets.symmetric(horizontal: 42, vertical: 20),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28),
            borderSide: BorderSide(color: primaryColor),
            gapPadding: 10),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28),
            borderSide: BorderSide(color: primaryFocusColor),
            gapPadding: 10),
      ),
    );
  }

  TextFormField priceForm() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: "Price",
        hintText: "Enter price's product",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: EdgeInsets.symmetric(horizontal: 42, vertical: 20),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28),
            borderSide: BorderSide(color: primaryColor),
            gapPadding: 10),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28),
            borderSide: BorderSide(color: primaryFocusColor),
            gapPadding: 10),
      ),
    );
  }

  SmartSelect statusForm() {
    String value = 'BOTH';
    List<S2Choice<String>> options = [
      S2Choice<String>(value: 'BOTH', title: 'Change and Trade'),
      S2Choice<String>(value: 'Change', title: 'Change'),
      S2Choice<String>(value: 'Trade', title: 'Trade'),
    ];
    return SmartSelect.single(
        title: "Choose a form of sale",
        value: value,
        onChange: (state) => value = state.value,
        choiceItems: options,
        modalType: S2ModalType.popupDialog);
  }

  SmartSelect categoryForm() {
    String _car = '';
    // List<Map<String, dynamic>> a = list[1].;
    return SmartSelect<String>.single(
      title: 'Category',
      placeholder: 'Choose one',
      value: _car,
      onChange: (selected) => setState(() => _car = selected.value),
      choiceItems: S2Choice.listFrom<String, Map>(
        source: Fake.categoryFake,
        value: (index, item) => item['idcategory'].toString(),
        title: (index, item) => item['name'],
        group: (index, item) => item['brandname'],
      ),
      choiceGrouped: true,
      modalFilter: true,
      modalFilterAuto: true,
      tileBuilder: (context, state) {
        return S2Tile.fromState(
          state,
          isTwoLine: true,
          // leading: const CircleAvatar(
          //   backgroundImage: NetworkImage(
          //     'https://source.unsplash.com/yeVtxxPxzbw/100x100',
          //   ),
          // ),
        );
      },
    );
  }

  @override
  void onLoadListCategory(List<CategoryRequest> lists) {
    // print(lists);
    setState(() {
      Fake.categoryFake = CategoryRequest.convert(lists);
      _isLoading = false;
      // print(data);
    });
  }

  @override
  void onLoadListCategoryError(String error) {
    setState(() {
      _isLoading = false;
    });
    print(error);
  }

  @override
  void onLoadImageComplete(ImageResult result) {
    imageResultList.add(result);
    print(result.url);
  }

  @override
  void onLoadImageError(String error) {
    print(error);
  }
}
