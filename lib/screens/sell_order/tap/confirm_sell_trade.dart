import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:old_change_app/models/input/exchange_result_list.dart';
import 'package:old_change_app/presenters/get_exchange_request_presenter.dart';

import 'package:old_change_app/models/purchase_dto.dart';
import 'package:old_change_app/models/user.dart';

import 'package:old_change_app/utilities/colors.dart';
import 'package:old_change_app/utilities/fake.dart';
import 'package:old_change_app/widgets/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfirmTrade extends StatefulWidget {
  const ConfirmTrade({Key key}) : super(key: key);

  @override
  _ConfirmTradeState createState() => _ConfirmTradeState();
}

class _ConfirmTradeState extends State<ConfirmTrade>
    implements GetExchangeRequestContract {
  bool isLoading = true;
  List<ExchangeForm> _list = [];
  GetExchangeRequestPresenter _exchangeRequestPresenter;
  User _user;

  Future<Null> getSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String user = prefs.get('User');
    _user = User.fromJson(json.decode(user));
  }

  @override
  void initState() {
    _exchangeRequestPresenter = GetExchangeRequestPresenter(this);
    getSharedPrefs()
        .then((_) => _exchangeRequestPresenter.onLoad(_user.id.toString()));
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
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
                          key: Key(_list[index].idRequest.toString()),
                          direction: DismissDirection.none,
                          background: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
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

  TextStyle dam() {
    return TextStyle(fontWeight: FontWeight.bold);
  }

  Widget body(ExchangeForm dto) {
    return Row(
      children: [
        imageR(dto),
        SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                width: getProportionateScreenWidth(220),
                child: RichText(
                  maxLines: null,
                  text: TextSpan(
                    text: "",
                    style: DefaultTextStyle.of(context).style,
                    children: <TextSpan>[
                      TextSpan(text: dto.user.fullName, style: dam()),
                      TextSpan(text: ' wants to exchange '),
                      TextSpan(text: dto.productExchange.name, style: dam()),
                      TextSpan(text: ' with your '),
                      TextSpan(text: dto.myproduct.name, style: dam()),
                    ],
                  ),
                )),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Money difference "),
                Text(
                    " ${NumberFormat.simpleCurrency(locale: 'vi').format(dto.priceDiff)}",
                    style: Theme.of(context).textTheme.bodyText1),
              ],
            ),
            Wrap(
              spacing: 5,
              runSpacing: 5,
              direction: Axis.horizontal,
              children: [
                OutlineButton(
                    child: Text("Accept"),
                    textColor: primaryColor,
                    borderSide: BorderSide(color: primaryColor),
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    onPressed: () {
                      // _acceptReuqestContract
                      //     .onLoad(dto.idOrderDetail.toString());
                      setState(() {
                        isLoading = true;
                      });
                    }),
                OutlineButton(
                    child: Text("Reject"),
                    textColor: Colors.red,
                    borderSide: BorderSide(color: Colors.red),
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    onPressed: () {})
              ],
            )
          ],
        )
      ],
    );
  }

  Widget imageR(ExchangeForm dto) {
    return SizedBox(
      width: 88,
      child: AspectRatio(
        aspectRatio: 0.88,
        child: Container(
          padding: EdgeInsets.all(getProportionateScreenWidth(10)),
          decoration: BoxDecoration(
            color: Color(0xFFF5F6F9),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Image.network(dto.productExchange.images[0].address),
        ),
      ),
    );
  }

  @override
  void onLoadExchangesError(String OnError) {
    Fake.showErrorDialog(OnError, "An error occurred!", context);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void onLoadExchangesSuccess(List<ExchangeForm> list) {
    if (list != null) {
      setState(() {
        _list = list;
        isLoading = false;
      });
    }
  }
}
