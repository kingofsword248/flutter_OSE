import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:old_change_app/screens/circle_exchange/screen_2/circle_two.dart';
import 'package:old_change_app/utilities/fake.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:old_change_app/models/input/cicle_one.dart';
import 'package:old_change_app/models/user.dart';
import 'package:old_change_app/presenters/circle_one_presenter.dart';
import 'package:old_change_app/utilities/colors.dart';
import 'package:old_change_app/widgets/size_config.dart';

class BodyOne extends StatefulWidget {
  int id;
  BodyOne({
    Key key,
    this.id,
  }) : super(key: key);

  @override
  _BodyOneState createState() => _BodyOneState();
}

class _BodyOneState extends State<BodyOne> implements CircleOneContract {
  List<CircleOne> _list = [];
  bool isLoading = true;
  User _a;
  CircleOnePresenter _circleOnePresenter;
  Future<bool> getSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String user = prefs.get('User');
    if (user != null) {
      setState(() {
        _a = User.fromJson(json.decode(user));
      });
      return true;
    } else {
      return false;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSharedPrefs();
    _circleOnePresenter = CircleOnePresenter(this);
    _circleOnePresenter.onLoad(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10)),
      child: isLoading == true
          ? Center(
              child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(primaryColor),
              ),
            )
          : _list.isEmpty
              ? Center(
                  child: Text("There are no products here !"),
                )
              : ListView.builder(
                  itemCount: _list.length,
                  itemBuilder: (context, index) => Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Dismissible(
                          key: Key(_list[index].tradeMappingCode.toString()),
                          direction: DismissDirection.none,
                          background: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFE6E6),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(
                              children: [
                                Spacer(),
                                SvgPicture.asset("assets/icons/Trash.svg"),
                              ],
                            ),
                          ),
                          child: body(
                            _list[index],
                          ),
                        ),
                      )),
    );
  }

  int findExchangeProduct(CircleOne dto) {
    for (int i = 0; i < dto.listProductInCircle.length; i++) {
      if (dto.listProductInCircle[i].own == _a.id) {
        for (int j = 0; j < dto.listProductInCircle.length; j++) {
          if (dto.listProductInCircle[i].toRequestID ==
              dto.listProductInCircle[j].idRequest) {
            return j;
          }
        }
      }
    }
    return -1;
  }

  int findMyProduct(CircleOne dto) {
    for (int i = 0; i < dto.listProductInCircle.length; i++) {
      if (dto.listProductInCircle[i].own == _a.id) {
        return i;
      }
    }
    return -1;
  }

  Widget body(CircleOne dto) {
    int index = findExchangeProduct(dto);
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          )
        ],
      ),
      child: Row(
        children: [
          imageR(dto.listProductInCircle[index]),
          SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: getProportionateScreenWidth(220),
                child: Text(
                  dto.listProductInCircle[index].name,
                  overflow: TextOverflow.visible,
                  style: TextStyle(color: Colors.black, fontSize: 18),
                  maxLines: 2,
                ),
              ),
              Container(
                width: getProportionateScreenWidth(220),
                child: Text(
                  "Own : " + dto.listProductInCircle[index].fullName,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.black, fontSize: 18),
                  maxLines: 2,
                ),
              ),
              Text(
                  "Total : ${NumberFormat.simpleCurrency(locale: 'vi').format(dto.listProductInCircle[index].price)}",
                  style: Theme.of(context).textTheme.bodyText1),
              Container(
                  width: getProportionateScreenWidth(220),
                  alignment: Alignment.centerRight,
                  child: OutlineButton(
                      child: Text("View Exchange Detail"),
                      textColor: primaryColor,
                      borderSide: BorderSide(color: primaryColor),
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      onPressed: () async {
                        int myIndex = findMyProduct(dto);
                        final rs = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CircleTwo(
                                      item: dto,
                                      exchangeIndex: index,
                                      myIndex: myIndex,
                                    )));
                        if (rs != null) {
                          _circleOnePresenter.onLoad(widget.id);
                          setState(() {
                            isLoading = true;
                          });
                        }
                      })),
            ],
          )
        ],
      ),
    );
  }

  Widget imageR(ListProductInCircle dto) {
    return SizedBox(
      width: 88,
      child: AspectRatio(
        aspectRatio: 0.88,
        child: Container(
          padding: EdgeInsets.all(getProportionateScreenWidth(10)),
          decoration: BoxDecoration(
            color: Color(0xFFF5F6F9),
            borderRadius: BorderRadius.circular(10),
          ),
          child: InkWell(
            onTap: () {
              Fake.onProductSelected(dto.idProduct, context);
            },
            child: Image.network(dto.imageProduct[0].address),
          ),
        ),
      ),
    );
  }

  @override
  void onOneError(String onError) {
    setState(() {
      isLoading = false;
    });
    print(onError);
  }

  @override
  void onOneSuccess(List<CircleOne> list) {
    setState(() {
      _list = list;
      isLoading = false;
    });
  }
}
