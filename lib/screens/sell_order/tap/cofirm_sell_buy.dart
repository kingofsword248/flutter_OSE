import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:old_change_app/screens/detail_page/detail_page.dart';
import 'package:old_change_app/utilities/fake.dart';
import 'package:old_change_app/models/purchase_dto.dart';
import 'package:old_change_app/models/user.dart';
import 'package:old_change_app/presenters/accept_sell_presenter.dart';
import 'package:old_change_app/presenters/purchase_presenter.dart';
import 'package:old_change_app/utilities/colors.dart';
import 'package:old_change_app/widgets/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfirmSell extends StatefulWidget {
  final String index;
  const ConfirmSell({Key key, this.index}) : super(key: key);

  @override
  _ConfirmSellState createState() => _ConfirmSellState();
}

class _ConfirmSellState extends State<ConfirmSell>
    implements PurchaseContract, AcceptReuqestContract {
  PurchasePresenter _purchasePresenter;
  bool isLoading = true;
  AcceptRequestPresenter _acceptReuqestContract;
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
    _acceptReuqestContract = AcceptRequestPresenter(this);
    _purchasePresenter = PurchasePresenter(this);
    getSharedPrefs().then((value) =>
        {_purchasePresenter.loadPurchaseList(value.id, widget.index, "sell")});
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
                          child: body(
                            _list[index],
                            widget.index,
                          ),
                        ),
                      )),
    );
  }

  Widget body(PurchaseDTO dto, String indexPage) {
    return Row(
      children: [
        SizedBox(
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
                    onProductSelected(dto.product[0].idProduct);
                  },
                  child: dto.product[0].images.isNotEmpty
                      ? Image.network(dto.product[0].images[0].address)
                      : Image.asset("assets/images/not.png")),
            ),
          ),
        ),
        SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: getProportionateScreenWidth(220),
              child: Text(
                dto.product[0].name,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.black, fontSize: 18),
                maxLines: 2,
              ),
            ),
            Text(
              "Quantity : " + dto.quantity.toString(),
              style: TextStyle(fontSize: 16),
            ),
            Text(
                "Total : ${NumberFormat.simpleCurrency(locale: 'vi').format(dto.price)}",
                style: Theme.of(context).textTheme.bodyText1),
            if (indexPage.contains("1"))
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
                        _acceptReuqestContract
                            .onLoad(dto.idOrderDetail.toString());
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

  @override
  void onLoadComplte(List<PurchaseDTO> list) {
    setState(() {
      _list = list;
      isLoading = false;
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

  @override
  void onRequestError(String error) {
    Fake.showErrorDialog(error, "An error occurred!", context);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Future<void> onRequestSuccess(bool isComplete) async {
    if (isComplete) {
      getSharedPrefs().then((value) => {
            _purchasePresenter.loadPurchaseList(value.id, widget.index, "sell")
          });
      Fake.showDiaglog(context, "Accept Success");
    }
  }

  onProductSelected(int id) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DetailScreen(
                  productID: id,
                )));
  }
}
