import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:old_change_app/constants/colors.dart';
import 'package:old_change_app/data/fake.dart';
import 'package:old_change_app/models/purchase_dto.dart';
import 'package:old_change_app/models/user.dart';
import 'package:old_change_app/presenters/confirm_presenter.dart';
import 'package:old_change_app/presenters/purchase_presenter.dart';
import 'package:old_change_app/screens/purchase_order/tap/confirm_screen/confirm_body.dart';
import 'package:old_change_app/widgets/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeliveryTap extends StatefulWidget {
  final String indexPage;
  final String mode;
  const DeliveryTap({Key key, this.indexPage, @required this.mode})
      : super(key: key);

  @override
  _DeliveryTapState createState() => _DeliveryTapState();
}

class _DeliveryTapState extends State<DeliveryTap>
    implements PurchaseContract, ConfirmPurchaseContract {
  PurchasePresenter _purchasePresenter;
  ConfirmPurchasePresenter _confirmPurchasePresenter;
  bool isLoading = true;
  int count = 0;
  // User _user;
  List<PurchaseDTO> _list = [];

  _DeliveryTapState();
  Future<User> getSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String user = prefs.get('User');
    return User.fromJson(json.decode(user));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _confirmPurchasePresenter = ConfirmPurchasePresenter(this);
    _purchasePresenter = PurchasePresenter(this);
    getSharedPrefs().then((value) => {
          _purchasePresenter.loadPurchaseList(
              value.id, widget.indexPage, widget.mode)
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
                          child: ConfirmBody(
                            dto: _list[index],
                            indexPage: widget.indexPage,
                            confirm: confirmOnClick,
                            mode: widget.mode,
                          ),
                        ),
                      )),
    );
  }

  @override
  void onLoadComplte(List<PurchaseDTO> list) {
    setState(() {
      _list = _list + list;
      if (widget.indexPage.contains("3")) {
        count++;
        if (count == 1) {
          getSharedPrefs().then((value) => {
                _purchasePresenter.loadPurchaseList(value.id, "7", widget.mode)
              });
        } else if (count == 2) {
          isLoading = false;
        }
      } else {
        isLoading = false;
      }
    });
  }

  @override
  void onLoadError(String error) {
    print(error.toString());
    setState(() {
      _list = [];
      isLoading = false;
    });
  }

  Function confirmOnClick(String id) {
    _confirmPurchasePresenter.confirm(id);
  }

  @override
  void onErrorConfirmError(String onError) {
    // TODO: implement onErrorConfirmError
  }

  @override
  void onLoadConfirmSuccess(bool Success) {
    if (Success) {
      count = 0;
      setState(() {
        isLoading = true;
        _list.clear();
      });
      getSharedPrefs().then((value) => {
            _purchasePresenter.loadPurchaseList(
                value.id, widget.indexPage, widget.mode)
          });

      Fake.showDiaglog(context, "Success");
    } else {
      Fake.showErrorDialog(
          "Opps! Something went wrong, Try again.", "Error", context);
    }
  }
}
