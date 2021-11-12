import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:old_change_app/constants/colors.dart';
import 'package:old_change_app/data/fake.dart';
import 'package:old_change_app/models/input/category_request.dart';
import 'package:old_change_app/models/input/post_image_result.dart';
import 'package:old_change_app/models/input/post_product_result.dart';
import 'package:old_change_app/models/input/product_form.dart';
import 'package:old_change_app/models/user.dart';
import 'package:old_change_app/presenters/categories_presenter.dart';
import 'package:old_change_app/presenters/load_image_presenter.dart';
import 'package:old_change_app/presenters/post_product_presenter.dart';
import 'package:old_change_app/screens/cart/widgets/default_button.dart';
import 'package:old_change_app/widgets/form_error.dart';
import 'package:old_change_app/widgets/keyboard.dart';
import 'package:old_change_app/widgets/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_select/smart_select.dart';

class Body extends StatefulWidget {
  const Body({Key key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body>
    implements CategoryContract, LoadImageContract, PostProductContract {
  //Postproduct
  PostProductPresenter _postProductPresenter;
  //catefory
  CategoryPresenter _categoryPresenter;
  List<CategoryRequest> listCategories;
  // List<Map<String, dynamic>> data;
  var _isLoading = false;
  //load image
  List<XFile> _files = [];
  bool uploadImageLoading = false;
  // List<ImageResult> imageResultList = [];
  LoadImagePresenter _imagePresenter;
  //form
  final _formKey = GlobalKey<FormState>();
  //local var
  List<ImageP> imageList = [];
  // ProductPost productPost;
  String name;
  String description;
  int quantity;
  int price;
  int categoryID;
  int categoryChangeID;
  //validate
  final List<String> errors = [];
  void addError({String error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({String error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  void checkCategoryChange(String value) {
    setState(() {
      Fake.status = value;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _categoryPresenter = CategoryPresenter(this);
    _imagePresenter = LoadImagePresenter(this);
    _postProductPresenter = PostProductPresenter(this);
    if (Fake.categoryFake.isEmpty) {
      setState(() {
        _isLoading = true;
      });
      _categoryPresenter.loadCategory();
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
                      const SizedBox(
                        height: 20,
                      ),
                      if (Fake.categoryFake.isNotEmpty &&
                          !Fake.status.contains("SELL"))
                        categoryWantedForm(),
                      imageWidgets(),
                      FormError(errors: errors),
                      DefaultButton(
                        text: "Post Product",
                        press: () async {
                          //check validate
                          if (imageList.isEmpty) {
                            addError(error: pPictures);
                            return;
                          } else if (imageList.isNotEmpty) {
                            removeError(error: pPictures);
                          }
                          if (categoryID == null) {
                            addError(error: pCategoryError);
                            return;
                          } else {
                            removeError(error: pCategoryError);
                          }
                          if (!Fake.status.contains("SELL") &&
                              categoryChangeID == null) {
                            addError(error: pCategoryTrade);
                            return;
                          } else {
                            removeError(error: pCategoryTrade);
                          }
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                            //thêm user
                            final prefs = await SharedPreferences.getInstance();
                            User a;
                            String user = prefs.get('User');
                            if (user != null) {
                              a = User.fromJson(json.decode(user));
                            }
                            if (Fake.status == "SELL") {
                              categoryChangeID = 0;
                            }
                            ProductPost productPost = ProductPost(
                                name: name,
                                description: description,
                                quantity: quantity,
                                price: price,
                                image: imageList,
                                own: a.id,
                                status: Fake.status,
                                categoryID: categoryID,
                                categoryChangeID: categoryChangeID);
                            //

                            setState(() {
                              _isLoading = true;
                            });
                            _postProductPresenter.postProduct(productPost);
                            KeyboardUtil.hideKeyboard(context);
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20,
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
        _files.isEmpty
            ? Text("Upload your Image (Maximun is 3)")
            : Wrap(
                children: [
                  if (uploadImageLoading == false)
                    OutlineButton(
                        child: Text(
                          "Load Image to Server",
                          style: TextStyle(color: primaryColor),
                        ),
                        onPressed: () {
                          if (_files == null) return;
                          if (_files.length == imageList.length) {
                            Fake.showErrorDialog(
                                "Loading is Complete", "notification", context);
                            return;
                          }
                          setState(() {
                            uploadImageLoading = true;
                          });
                          for (var i = 0; i < _files.length; i++) {
                            _imagePresenter.loadImage(File(_files[i].path));
                          }
                        }),
                  if (uploadImageLoading)
                    Text("Loading... (${imageList.length}/${_files.length})")
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
      onSaved: (newValue) => name = newValue,
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
      onSaved: (newValue) => description = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: pDesNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: pDesNullError);
          return "";
        }
        return null;
      },
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
      onSaved: (newValue) => quantity = int.parse(newValue),
      // keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
      onChanged: (value) {
        // if (int.parse(value) > 0) {
        //   removeError(error: pQuantityIFError);
        // }
        if (value.isNotEmpty) {
          removeError(error: pQuantityNullError);
        }
        return null;
      },
      validator: (value) {
        print(value);
        // if (int.parse(value) <= 0) {
        //   addError(error: pQuantityIFError);
        //   return "";
        // }
        if (value.length == 0) {
          addError(error: pQuantityIFError);
          return "";
        }
        return null;
      },
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
      onSaved: (newValue) => price = int.parse(newValue),
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
      onChanged: (value) {
        // if (int.parse(value) > 0) {
        //   removeError(error: pPriceIFError);
        // }
        if (value.isNotEmpty) {
          removeError(error: pPriceNullError);
        }
        return null;
      },
      validator: (value) {
        // if (int.parse(value) <= 0) {
        //   addError(error: pPriceIFError);
        //   return "";
        // }
        if (value.length == 0) {
          addError(error: pPriceNullError);
          return "";
        }
        return null;
      },
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
    List<S2Choice<String>> options = [
      S2Choice<String>(value: 'BOTH', title: 'Sell and Exchange'),
      S2Choice<String>(value: 'SELL', title: 'Sell'),
      S2Choice<String>(value: 'EXCHANGE', title: 'Exchange'),
    ];
    return SmartSelect.single(
        title: "Choose a form of sale",
        value: Fake.status,
        onChange: (state) {
          checkCategoryChange(state.value);
        },
        choiceItems: options,
        modalType: S2ModalType.popupDialog);
  }

  SmartSelect categoryForm() {
    // String _car = '';
    // List<Map<String, dynamic>> a = list[1].;
    return SmartSelect<String>.single(
      title: 'Category',
      placeholder: 'Choose one',
      value: categoryID.toString(),
      onChange: (selected) =>
          setState(() => categoryID = int.parse(selected.value)),
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

  SmartSelect categoryWantedForm() {
    // String _car = '';
    // List<Map<String, dynamic>> a = list[1].;
    return SmartSelect<String>.single(
      title: 'The type of product you want to exchange',
      placeholder: 'Choose one',
      value: categoryChangeID.toString(),
      onChange: (selected) =>
          setState(() => categoryChangeID = int.parse(selected.value)),
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
    setState(() {
      imageList.add(ImageP(url: result.url));
      if (imageList.length == _files.length) {
        uploadImageLoading = false;
      }
    });
  }

  @override
  void onLoadImageError(String error) {
    Fake.showErrorDialog("Something wrong", "Notification Error", context);
    setState(() {
      uploadImageLoading = false;
    });
  }

  @override
  void onPostProductComplete(PostProductResult ppr) {
    Fake.showErrorDialog(ppr.message, "Notification", context);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void onPostProductError(String error) {
    Fake.showErrorDialog(error, "Notification Error", context);
    setState(() {
      _isLoading = false;
    });
  }
}
