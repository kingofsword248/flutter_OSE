import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:old_change_app/models/product_real.dart';
import 'package:old_change_app/models/cart_request.dart';
import 'package:old_change_app/models/user.dart';
import 'package:old_change_app/presenters/exchange_product_presenter.dart';
import 'package:old_change_app/presenters/load_my_product_presenter.dart';
import 'package:old_change_app/utilities/colors.dart';
import 'package:old_change_app/utilities/fake.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_select/smart_select.dart';

class BottomSheetExchange extends StatefulWidget {
  final Product product;
  const BottomSheetExchange({Key key, this.product}) : super(key: key);

  @override
  _BottomSheetExchangeState createState() => _BottomSheetExchangeState();
}

class _BottomSheetExchangeState extends State<BottomSheetExchange>
    implements LoadMyProductContract, ExchangeProductContract {
  LoadMyProductPresenter _presenter;
  ExchangeProductPresenter _exchangeProductPresenter;
  User _a;
  List<Product> listP = [];
  String idProduct;
  bool _isLoading = false;
  @override
  void initState() {
    _presenter = LoadMyProductPresenter(this);
    _exchangeProductPresenter = ExchangeProductPresenter(this);
    getSharedPrefs().then((_) {
      if (_a != null) {
        _presenter.onLoad(_a.token);
      }
    });
    super.initState();
  }

  Future<bool> getSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String user = prefs.get('User');
    if (user != null) {
      setState(() {
        _a = User.fromJson(json.decode(user));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<S2Choice<String>> options = listP
        .map((e) =>
            S2Choice<String>(value: e.idProduct.toString(), title: e.name))
        .toList();
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(28),
        child: Wrap(
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
                  'Trade',
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
            if (!options.isEmpty)
              SmartSelect.single(
                title: 'Your Product',
                value: null,
                onChange: (state) => idProduct = state.value,
                choiceItems: options,
                modalType: S2ModalType.popupDialog,
              ),
            if (options.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Center(
                  child: Text(
                    'You dont have any product to trade',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            _isLoading == true
                ? const Center(child: CircularProgressIndicator())
                : Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(vertical: 20),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7)),
                      textColor: Colors.white,
                      color: primaryColor,
                      padding: EdgeInsets.all(20),
                      child: Text(
                        'Request to Trade',
                        style: TextStyle(fontSize: 16),
                      ),
                      onPressed: () async {
                        if (idProduct == null) {
                          Fake.showErrorDialog(
                              "Choice a your products to exchange",
                              "Notitications",
                              context);
                          return;
                        }
                        _exchangeProductPresenter.onLoad(_a.id,
                            widget.product.idProduct, int.parse(idProduct));
                        setState(() {
                          _isLoading = true;
                        });
                      },
                    ),
                  )
          ],
        ),
      ),
    );
  }

  void close(context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }

  @override
  void onExchangeError(String error) {
    Fake.showErrorDialog(error, "Notification", context);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void onExchangeSuccess(Result rs) {
    if (rs != null) {
      setState(() {
        _isLoading = false;
      });
      Fake.showErrorDialog(rs.result, "Notification", context);
    } else {
      Fake.showErrorDialog("Something wrong", "Notification", context);
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void onLoadMyProductError(String error) {
    // TODO: implement onLoadMyProductError
  }

  @override
  void onLoadMyProductSuccess(List<Product> list) {
    setState(() {
      listP = list;
    });
  }
}
