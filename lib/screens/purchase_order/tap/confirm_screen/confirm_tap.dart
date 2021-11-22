import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:old_change_app/utilities/fake.dart';
import 'package:old_change_app/models/purchase_dto.dart';
import 'package:old_change_app/models/user.dart';
import 'package:old_change_app/presenters/cancel_presenter.dart';
import 'package:old_change_app/presenters/purchase_presenter.dart';
import 'package:old_change_app/screens/purchase_order/tap/confirm_screen/confirm_body.dart';
import 'package:old_change_app/utilities/colors.dart';
import 'package:old_change_app/widgets/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfirmTap extends StatefulWidget {
  final String indexPage;
  const ConfirmTap({Key key, this.indexPage}) : super(key: key);

  @override
  _ConfirmTapState createState() => _ConfirmTapState();
}

class _ConfirmTapState extends State<ConfirmTap>
    implements PurchaseContract, CancelOrderDetailContract {
  PurchasePresenter _purchasePresenter;
  CancelOrderDetailPresenter _cancelOrderDetailPresenter;
  bool isLoading = true;
  // User _user;
  List<PurchaseDTO> _list = [];
  Future<User> getSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String user = prefs.get('User');
    return User.fromJson(json.decode(user));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cancelOrderDetailPresenter = CancelOrderDetailPresenter(this);
    _purchasePresenter = PurchasePresenter(this);
    getSharedPrefs().then((value) => {
          _purchasePresenter.loadPurchaseList(
              value.id, widget.indexPage, "purchase")
        });
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
                          key: Key(_list[index].idOrderDetail.toString()),
                          onDismissed: (direction) => {
                            _cancelOrderDetailPresenter.cancelOrder(
                                _list[index].idOrderDetail.toString()),
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
                                  content:
                                      Text('Do you want to cancel your order?'),
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
                          child: ConfirmBody(
                            dto: _list[index],
                            indexPage: widget.indexPage,
                          ),
                        ),
                      )),
    );
  }

  @override
  void onLoadComplte(List<PurchaseDTO> list) {
    setState(() {
      _list = list;
      isLoading = false;
    });
  }

  @override
  void onLoadError(String error) {
    setState(() {
      _list = [];
      isLoading = false;
    });
  }

  @override
  void onCancelOrderComplete(bool isSuccess) {
    if (isSuccess) {
      getSharedPrefs().then((value) => {
            _purchasePresenter.loadPurchaseList(
                value.id, widget.indexPage, "purchase")
          });
    }
  }

  @override
  void onCancelOrderError(String error) {
    Fake.showErrorDialog(error, "An Error Occured", context);
  }
}
