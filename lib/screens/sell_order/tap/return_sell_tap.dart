import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import 'package:old_change_app/models/refund.dart';
import 'package:old_change_app/presenters/accept_refund_seller_presenter.dart';
import 'package:old_change_app/presenters/disagree_refund_seller_presenter.dart';

import 'package:old_change_app/presenters/load_refund_sell_presenter.dart';

import 'package:old_change_app/screens/detail_page/detail_page.dart';
import 'package:old_change_app/utilities/colors.dart';
import 'package:old_change_app/utilities/fake.dart';
import 'package:old_change_app/widgets/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RefundSell extends StatefulWidget {
  RefundSell({
    Key key,
  }) : super(key: key);

  @override
  _RefundSellState createState() => _RefundSellState();
}

class _RefundSellState extends State<RefundSell>
    implements
        RefundSellContract,
        AcceptRefundSellerContract,
        DisagreeRefundContract {
  bool isLoading = true;
  List<RefundDTO> _list = [];

// part 1
  DisagreeRefundPresenter _disagreeRefundPresenter;
  RefundSellPresenter _refundSellPresenter;
  AcceptRefundSellerPresenter _acceptRefundSellerPresenter;
  // part 2

  final _formKey = GlobalKey<FormState>();
  String reason;

  @override
  void initState() {
    _disagreeRefundPresenter = DisagreeRefundPresenter(this);
    _refundSellPresenter = RefundSellPresenter(this);
    _acceptRefundSellerPresenter = AcceptRefundSellerPresenter(this);
    super.initState();
    getSharedPrefs().then((value) => _refundSellPresenter.onLoad(value.id));
  }

  Future<User> getSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String user = prefs.get('User');
    return User.fromJson(json.decode(user));
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
                        child: body(
                          _list[index],
                        ),
                      )),
    );
  }

  // TextStyle dam() {
  //   return TextStyle(fontWeight: FontWeight.bold);
  // }

  Widget body(RefundDTO dto) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          children: [
            imageR(dto),
            SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: getProportionateScreenWidth(250),
                  child: Text(
                    dto.product.name + " x" + dto.quantity.toString(),
                    overflow: TextOverflow.visible,
                    style: TextStyle(color: Colors.black, fontSize: 18),
                    maxLines: 2,
                  ),
                ),
                Container(
                  width: getProportionateScreenWidth(220),
                  child: Text(
                    "Total : ${NumberFormat.simpleCurrency(locale: 'vi').format(dto.price)}",
                    overflow: TextOverflow.visible,
                    style: TextStyle(color: Colors.black, fontSize: 18),
                    maxLines: 2,
                  ),
                ),
                // Container(
                //   width: getProportionateScreenWidth(220),
                //   child: Text(
                //     "Phone: " +
                //         (widget.index.contains("0")
                //             ? dto.phoneSend
                //             : dto.phoneReceive),
                //     overflow: TextOverflow.visible,
                //     style: TextStyle(color: Colors.black, fontSize: 18),
                //     maxLines: 2,
                //   ),
                // ),
                if (dto.status.contains("6"))
                  statusComponent(
                      "Waiting for you to confirm the return", Colors.red[700]),
                if (dto.status.contains("12"))
                  statusComponent(
                      "Waiting for the admin to resolve", Colors.blue[600]),
                if (dto.status.contains("11"))
                  statusComponent("Refund refused", Colors.red[800]),
                if (dto.status.contains("8"))
                  statusComponent("Accepted returns", Colors.green[700]),
                if (dto.status.contains("9"))
                  statusComponent("Order is being shipped", Colors.green[700]),
                if (dto.status.contains("10"))
                  statusComponent("Returned order complete", Colors.green[900]),
                if (dto.status.contains("11"))
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        "assets/icons/speech-bubble-with-exclamation-mark-svgrepo-com.svg",
                        color: primaryColor,
                        height: 20,
                      ),
                      Container(
                        width: getProportionateScreenWidth(200),
                        child: Text(
                          " " + dto.description,
                          overflow: TextOverflow.visible,
                          style: TextStyle(color: Colors.black, fontSize: 16),
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                if (dto.status.contains("8") ||
                    dto.status.contains("9") ||
                    dto.status.contains("10"))
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        "assets/icons/delivery-truck-svgrepo-com.svg",
                        color: Colors.green[700],
                        height: 20,
                      ),
                      Container(
                        width: getProportionateScreenWidth(200),
                        child: Text(
                          " " + dto.transport,
                          overflow: TextOverflow.visible,
                          style: TextStyle(color: Colors.black, fontSize: 16),
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ],
        ),
        if (dto.status.contains("11"))
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset(
                "assets/icons/information-svgrepo-com.svg",
                color: Colors.blueGrey,
                height: 20,
              ),
              Container(
                padding: EdgeInsets.only(right: 10),
                // width: getProportionateScreenWidth(220),
                child: Text(
                  " Waiting for buyer's response before " + dto.timeLimitAccept,
                  overflow: TextOverflow.visible,
                  style: TextStyle(color: Colors.blueGrey, fontSize: 15),
                  maxLines: 2,
                ),
              ),
            ],
          ),
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Wrap(
            spacing: 5,
            runSpacing: 5,
            direction: Axis.horizontal,
            alignment: WrapAlignment.end,
            children: [
              if (dto.status.contains("6"))
                OutlineButton(
                    child: Text("Agree"),
                    textColor: Colors.green[700],
                    borderSide: BorderSide(color: primaryColor),
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Agree to refund'),
                            content: Text('Do you want to Agree to refund?'),
                            actions: <Widget>[
                              FlatButton(
                                onPressed: () {
                                  // Navigator.pop(context, false);
                                  Navigator.of(
                                    context,
                                    // rootNavigator: true,
                                  ).pop();
                                },
                                child: Text('No'),
                              ),
                              FlatButton(
                                onPressed: () {
                                  // Navigator.pop(context, true);

                                  Navigator.of(
                                    context,
                                    // rootNavigator: true,
                                  ).pop();
                                  _acceptRefundSellerPresenter
                                      .onLoad(dto.idOrderDetail);
                                  setState(() {
                                    isLoading = true;
                                  });
                                },
                                child: Text('Yes'),
                              ),
                            ],
                          );
                        },
                      );
                    }),
              if (dto.status.contains("6"))
                OutlineButton(
                    child: Text("Disagree"),
                    textColor: Colors.red[700],
                    borderSide: BorderSide(color: primaryColor),
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    onPressed: () {
                      _settingDisagreeModalBottomSheet(dto.idOrderDetail);
                    }),
              OutlineButton(
                  child: Text("Return reason"),
                  textColor: primaryColor,
                  borderSide: BorderSide(color: primaryColor),
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  onPressed: () {
                    _settingRefundModalBottomSheet(context, dto);
                  })
            ],
          ),
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

  Widget imageR(RefundDTO dto) {
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
                onProductSelected(dto.product.idProduct);
              },
              child: dto.product.images.isNotEmpty
                  ? Image.network(dto.product.images[0].address)
                  : Image.asset("assets/images/not.png")),
        ),
      ),
    );
  }

  void _settingRefundModalBottomSheet(context, RefundDTO dto) {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        context: context,
        builder: (BuildContext bc) {
          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(28),
              child: Wrap(
                alignment: WrapAlignment.center,
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
                            if (Navigator.canPop(context))
                              Navigator.pop(context);
                          },
                        ),
                      ),
                      Text(
                        'Refund Reason',
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
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      'Reason',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(top: 20),
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      alignment: WrapAlignment.center,
                      children: [
                        Row(
                          children: [
                            if (dto.user[0].avatar != null)
                              CircleAvatar(
                                child: Image.network(dto.user[0].avatar),
                              ),
                            Text(
                              " " + dto.user[0].fullName,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: contentForm(dto.reasonRefund),
                        ),

                        SizedBox(
                          height: 70,
                        ),
                        dto.imageRefund.isEmpty
                            ? const Text("No picture")
                            : GridView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3),
                                itemCount: dto.imageRefund.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.network(
                                          dto.imageRefund[index].address));
                                }),
                        // imageWidgets()
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void _settingDisagreeModalBottomSheet(int idOrderDetail) {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        context: context,
        builder: (BuildContext bc) {
          var size = MediaQuery.of(context).size;
          return Container(
            padding: EdgeInsets.all(28),
            child: Wrap(
              alignment: WrapAlignment.center,
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
                          if (Navigator.canPop(context)) Navigator.pop(context);
                        },
                      ),
                    ),
                    Text(
                      'Reason',
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
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    'Input Reason',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(top: 20),
                  child: isLoading == true
                      ? CircularProgressIndicator()
                      : Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          alignment: WrapAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  bottom: MediaQuery.of(bc).viewInsets.bottom),
                              child: contentForm2(),
                            ),

                            // imageWidgets()
                          ],
                        ),
                ),
                if (isLoading == false) submitButtom(idOrderDetail)
              ],
            ),
          );
        });
  }

  Widget contentForm2() {
    return Form(
      key: _formKey,
      child: TextFormField(
        maxLines: 4,
        keyboardType: TextInputType.text,
        onSaved: (newValue) => reason = newValue,
        onChanged: (value) {
          // if (value.isNotEmpty) {
          //   removeError(error: kEmailNullError);
          // } else if (emailValidatorRegExp.hasMatch(value)) {
          //   removeError(error: kInvalidEmailError);
          // }
          // return null;
        },
        validator: (value) {
          if (value.isEmpty) {
            return "Reason is empty";
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: "Reason",
          hintText: "Enter your Reason",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          contentPadding: EdgeInsets.symmetric(horizontal: 42, vertical: 20),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: primaryColor),
              gapPadding: 10),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: primaryFocusColor),
              gapPadding: 10),
        ),
      ),
    );
  }

  Widget submitButtom(int idTranport) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 20),
      child: RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
        textColor: Colors.white,
        color: primaryColor,
        padding: EdgeInsets.all(20),
        child: Text(
          'Submit',
          style: TextStyle(fontSize: 16),
        ),
        onPressed: () {
          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();
            _disagreeRefundPresenter.onLoad(reason, idTranport);
            setState(() {
              isLoading = true;
            });
          }

          // close(context);
        },
      ),
    );
  }

  Widget statusComponent(String content, Color color) {
    return Row(
      children: [
        SvgPicture.asset(
          "assets/icons/notepad2-svgrepo-com.svg",
          color: color,
          height: 20,
        ),
        Container(
          width: getProportionateScreenWidth(220),
          child: Text(
            " " + content,
            overflow: TextOverflow.visible,
            style: TextStyle(color: color, fontSize: 16),
            maxLines: 2,
          ),
        ),
      ],
    );
  }

  Widget contentForm(String mess) {
    return TextFormField(
      initialValue: mess,
      readOnly: true,
      maxLines: 4,
      decoration: InputDecoration(
        labelText: "Message",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: EdgeInsets.symmetric(horizontal: 42, vertical: 20),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: primaryColor),
            gapPadding: 10),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: primaryFocusColor),
            gapPadding: 10),
      ),
    );
  }

  @override
  void onLoadRefundError(String e) {
    Fake.showErrorDialog(e, "Error", context);
  }

  @override
  void onLoadRefundSuccess(List<RefundDTO> list) {
    setState(() {
      _list = list;
      isLoading = false;
    });
  }

  @override
  void onAcceptError(String er) {
    Fake.showErrorDialog(er, "Error", context);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void onAcceptSuccess(String ss) {
    Fake.showErrorDialog(ss, "Notification", context);
    getSharedPrefs().then((value) => _refundSellPresenter.onLoad(value.id));
  }

  @override
  void onDisagreeError(String er) {
    Fake.showErrorDialog(er, "Error", context);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void onDisagreeSuccess(String success) {
    Navigator.pop(context);
    Fake.showErrorDialog(success, "Notification", context);
    getSharedPrefs().then((value) => _refundSellPresenter.onLoad(value.id));
  }
}
