import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:old_change_app/models/input/exchange_result_list.dart';
import 'package:old_change_app/presenters/cancel_exchange_presenter.dart';
import 'package:old_change_app/presenters/get_exchange_request_presenter.dart';
import 'package:old_change_app/screens/detail_page/detail_page.dart';
import 'package:old_change_app/utilities/fake.dart';
import 'package:old_change_app/models/purchase_dto.dart';
import 'package:old_change_app/models/user.dart';
import 'package:old_change_app/presenters/cancel_presenter.dart';
import 'package:old_change_app/presenters/purchase_presenter.dart';
import 'package:old_change_app/screens/purchase_order/tap/confirm_screen/confirm_body.dart';
import 'package:old_change_app/utilities/colors.dart';
import 'package:old_change_app/widgets/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfirmTrade extends StatefulWidget {
  const ConfirmTrade({Key key}) : super(key: key);

  @override
  _ConfirmTradeState createState() => _ConfirmTradeState();
}

class _ConfirmTradeState extends State<ConfirmTrade>
    implements GetExchangeRequestContract, CancelExchangeContract {
  GetExchangeRequestPresenter _exchangeRequestPresenter;
  CancelEchangePresenter _cancelEchangePresenter;
  bool isLoading = true;
  // User _user;
  List<ExchangeForm> _list = [];
  User _user;

  Future<Null> getSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String user = prefs.get('User');
    _user = User.fromJson(json.decode(user));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cancelEchangePresenter = CancelEchangePresenter(this);
    _exchangeRequestPresenter = GetExchangeRequestPresenter(this);
    getSharedPrefs().then((_) => _exchangeRequestPresenter.onLoad(
        _user.id.toString(), "listRequestWantChangePurchase"));
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
                            onDismissed: (direction) => {
                                  _cancelEchangePresenter
                                      .onCancel(_list[index].idRequest),
                                  setState(() {
                                    isLoading = true;
                                  })
                                },
                            direction: DismissDirection.endToStart,
                            confirmDismiss: (direction) {
                              return showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('Cancelled'),
                                    content: Text(
                                        'Do you want to cancel your exchange order?'),
                                    actions: <Widget>[
                                      FlatButton(
                                        onPressed: () {
                                          // Navigator.pop(context, false);
                                          Navigator.of(
                                            context,
                                            // rootNavigator: true,
                                          ).pop(false);
                                        },
                                        child: Text('No'),
                                      ),
                                      FlatButton(
                                        onPressed: () {
                                          // Navigator.pop(context, true);
                                          Navigator.of(
                                            context,
                                            // rootNavigator: true,
                                          ).pop(true);
                                        },
                                        child: Text('Yes'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            background: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
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
                            child: body(_list[index])),
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
                    text: "You have sent a request to exchange your ",
                    style: DefaultTextStyle.of(context).style,
                    children: <TextSpan>[
                      TextSpan(text: dto.myproduct.name, style: dam()),
                      TextSpan(text: ' with '),
                      TextSpan(text: dto.user.fullName, style: dam()),
                      TextSpan(text: '\'s '),
                      TextSpan(text: dto.productExchange.name, style: dam()),
                    ],
                  ),
                )),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                dto.priceDiff.isNegative
                    ? Text(
                        "Minus money",
                        style: TextStyle(color: Colors.orange[900]),
                      )
                    : Text("Receive money",
                        style: TextStyle(color: Colors.green[900])),
                Text(
                    " ${NumberFormat.simpleCurrency(locale: 'vi').format(dto.priceDiff)}",
                    style: Theme.of(context).textTheme.bodyText1),
              ],
            ),
          ],
        )
      ],
    );
  }

  onProductSelected(int id) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DetailScreen(
                  productID: id,
                )));
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
          child: InkWell(
              onTap: () {
                onProductSelected(dto.productExchange.idProduct);
              },
              child: Image.network(dto.productExchange.images[0].address)),
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

  @override
  void onCancelError(String error) {
    Fake.showErrorDialog(error, "Error", context);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void onCancelSuccess(bool success) {
    if (success) {
      getSharedPrefs().then((_) => _exchangeRequestPresenter.onLoad(
          _user.id.toString(), "listRequestWantChangePurchase"));
    } else {
      Fake.showDiaglog(context, "ERROR");
    }
  }
}
