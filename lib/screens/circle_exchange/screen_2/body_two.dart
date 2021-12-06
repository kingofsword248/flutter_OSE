import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:old_change_app/models/input/cicle_one.dart';
import 'package:old_change_app/models/user.dart';
import 'package:old_change_app/presenters/join_exchange_presenter.dart';
import 'package:old_change_app/presenters/reject_circle_presenter.dart';
import 'package:old_change_app/utilities/colors.dart';
import 'package:old_change_app/utilities/fake.dart';
import 'package:old_change_app/widgets/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class BodyTwo extends StatefulWidget {
  CircleOne item;
  int myIndex;
  int exchangeIndex;

  BodyTwo({Key key, this.item, this.exchangeIndex, this.myIndex})
      : super(key: key);

  @override
  _BodyTwoState createState() => _BodyTwoState();
}

class _BodyTwoState extends State<BodyTwo>
    implements JoinExchangeContract, RejectCircleContract {
  List<int> index3 = [0, 1, 2];
  JoinExchangePresenter _joinExchangePresenter;
  RejectCirclePresenter _rejectCirclePresenter;
  User _a;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _joinExchangePresenter = JoinExchangePresenter(this);
    _rejectCirclePresenter = RejectCirclePresenter(this);
    getSharedPrefs();
  }

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
  Widget build(BuildContext context) {
    index3.remove(widget.exchangeIndex);
    index3.remove(widget.myIndex);
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Column(
          children: [
            body(widget.item, widget.myIndex),
            if (widget.item.peopleInCircle == 2)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: SvgPicture.asset(
                  "assets/icons/round-arrows-svgrepo-com.svg",
                  color: primaryColor,
                  width: 100,
                ),
              ),
            if (widget.item.peopleInCircle == 3)
              SvgPicture.asset(
                "assets/icons/down-arrow-svgrepo-com.svg",
                color: primaryColor,
                width: 100,
              ),
            body(widget.item, widget.exchangeIndex),
            if (widget.item.peopleInCircle == 3)
              SvgPicture.asset(
                "assets/icons/down-arrow-svgrepo-com.svg",
                color: primaryColor,
                width: 100,
              ),
            if (widget.item.peopleInCircle == 3) body(widget.item, index3[0]),
            if (widget.item.listProductInCircle[widget.myIndex].status == "1")
              joinButtom(context),
            if (widget.item.listProductInCircle[widget.myIndex].status == "1")
              rejectButtom(context),
            if (widget.item.listProductInCircle[widget.myIndex].status == "2")
              canceltButtom(context)
          ],
        ),
      ),
    );
  }

  Widget body(CircleOne dto, int index) {
    // int index = findExchangeProduct(dto);
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        // borderRadius: BorderRadius.only(
        //     topLeft: Radius.circular(10),
        //     topRight: Radius.circular(10),
        //     bottomLeft: Radius.circular(10),
        //     bottomRight: Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
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
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.black, fontSize: 18),
                  maxLines: 2,
                ),
              ),
              Container(
                width: getProportionateScreenWidth(220),
                child: Text(
                  "Own : " + dto.listProductInCircle[index].fullName,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                  maxLines: 2,
                ),
              ),
              Text(
                  "Total : ${NumberFormat.simpleCurrency(locale: 'vi').format(dto.listProductInCircle[index].price)}",
                  style: Theme.of(context).textTheme.bodyText1),
              Row(
                children: [
                  if (dto.listProductInCircle[index].status == "1")
                    SvgPicture.asset(
                      "assets/icons/tick-circle-svgrepo-com.svg",
                      color: Colors.grey,
                      width: 22,
                    ),
                  if (dto.listProductInCircle[index].status == "1")
                    const Text(" Unconfirmed"),
                  if (dto.listProductInCircle[index].status == "2")
                    SvgPicture.asset(
                      "assets/icons/tick-circle-svgrepo-com.svg",
                      color: Colors.green,
                      width: 22,
                    ),
                  if (dto.listProductInCircle[index].status == "2")
                    const Text(" Exchange confirmed"),
                ],
              ),
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

  Widget joinButtom(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
        textColor: Colors.white,
        color: primaryColor,
        padding: EdgeInsets.all(20),
        child: Text(
          'Join exchange',
          style: TextStyle(fontSize: 16),
        ),
        onPressed: () {
          // close(context);
          _joinExchangePresenter.onLoad(_a.token, widget.item.tradeMappingCode);
        },
      ),
    );
  }

  Widget rejectButtom(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 10),
      child: RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
        textColor: Colors.white,
        color: Colors.orange[900],
        padding: EdgeInsets.all(20),
        child: Text(
          'Reject exchange',
          style: TextStyle(fontSize: 16),
        ),
        onPressed: () {
          // close(context);
          _rejectCirclePresenter.onLoad(_a.token, widget.item.tradeMappingCode);
        },
      ),
    );
  }

  Widget canceltButtom(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
        textColor: Colors.white,
        color: Colors.orange[900],
        padding: EdgeInsets.all(20),
        child: Text(
          'Cancel exchange',
          style: TextStyle(fontSize: 16),
        ),
        onPressed: () {
          _rejectCirclePresenter.onLoad(_a.token, widget.item.tradeMappingCode);
        },
      ),
    );
  }

  @override
  void onJoinError(String error) {
    Fake.showErrorDialog(error, "Error", context);
  }

  @override
  void onjoinSuccess(bool s) {
    if (s) {
      Fake.showDiaglog(context, "Join Success");
      Navigator.pop(context, "success");
    }
  }

  @override
  void onRejectError(String error) {
    Fake.showErrorDialog(error, "Error", context);
  }

  @override
  void onRejectSuccess(bool s) {
    if (s) {
      Fake.showDiaglog(context, "Join Success");
      Navigator.pop(context, "success");
    }
  }
}
