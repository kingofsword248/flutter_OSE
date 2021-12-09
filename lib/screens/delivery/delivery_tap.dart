import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:old_change_app/models/delivery.dart';
import 'package:old_change_app/presenters/deliveru_presenter.dart';
import 'package:old_change_app/presenters/delivery_success_presenter.dart';
import 'package:old_change_app/presenters/load_delivery_presenter.dart';
import 'package:old_change_app/presenters/update_status_presenter.dart';
import 'package:old_change_app/screens/delivery/delivery_bottom.dart';
import 'package:old_change_app/utilities/fake.dart';
import 'package:old_change_app/screens/detail_page/detail_page.dart';
import 'package:old_change_app/utilities/colors.dart';
import 'package:old_change_app/widgets/size_config.dart';

class DeliveryTap2 extends StatefulWidget {
  String url;
  String index;
  DeliveryTap2({Key key, @required this.url, @required this.index})
      : super(key: key);

  @override
  _DeliveryTap2State createState() => _DeliveryTap2State();
}

class _DeliveryTap2State extends State<DeliveryTap2>
    implements
        LoadDeliveryContract,
        DeliveryContract,
        DeliverySuccessContract,
        UpdateStatusContract {
  bool isLoading = true;
  List<Delivery> _list = [];
  LoadDeliveryPresenter _loadDeliveryPresenter;
  DeliveryPresenter _deliveryPresenter;
  DeliverySuccessPresenter _successPresenter;

  // part 2
  UpdateStatusPresenter _presenter;
  final _formKey = GlobalKey<FormState>();
  String reason;

  @override
  void initState() {
    // TODO: implement initState
    _presenter = UpdateStatusPresenter(this);
    _successPresenter = DeliverySuccessPresenter(this);
    _deliveryPresenter = DeliveryPresenter(this);
    _loadDeliveryPresenter = LoadDeliveryPresenter(this);
    _loadDeliveryPresenter.onLoad(widget.url);
    super.initState();
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
                          key: Key(_list[index].idTransport.toString()),
                          direction: DismissDirection.none,
                          // background: Container(
                          //   padding: const EdgeInsets.symmetric(horizontal: 10),
                          //   decoration: BoxDecoration(
                          //     color: const Color(0xFFFFE6E6),
                          //     borderRadius: BorderRadius.circular(15),
                          //   ),
                          //   child: Row(
                          //     children: [
                          //       Spacer(),
                          //       SvgPicture.asset("assets/icons/Trash.svg"),
                          //     ],
                          //   ),
                          // ),
                          child: body(
                            _list[index],
                          ),
                        ),
                      )),
    );
  }

  // TextStyle dam() {
  //   return TextStyle(fontWeight: FontWeight.bold);
  // }

  Widget body(Delivery dto) {
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
                    dto.name + " x" + dto.quantity.toString(),
                    overflow: TextOverflow.visible,
                    style: TextStyle(color: Colors.black, fontSize: 18),
                    maxLines: 2,
                  ),
                ),
                Container(
                  width: getProportionateScreenWidth(220),
                  child: Text(
                    widget.index.contains("0")
                        ? "Sender: " + dto.fullNameSend
                        : "Receiver: " + dto.fullNameReceive,
                    overflow: TextOverflow.visible,
                    style: TextStyle(color: Colors.black, fontSize: 18),
                    maxLines: 2,
                  ),
                ),
                Container(
                  width: getProportionateScreenWidth(220),
                  child: Text(
                    "Phone: " +
                        (widget.index.contains("0")
                            ? dto.phoneSend
                            : dto.phoneReceive),
                    overflow: TextOverflow.visible,
                    style: TextStyle(color: Colors.black, fontSize: 18),
                    maxLines: 2,
                  ),
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      "assets/icons/home-svgrepo-com.svg",
                      color: primaryColor,
                      height: 20,
                    ),
                    Container(
                      width: getProportionateScreenWidth(220),
                      child: Text(
                        " " +
                            (widget.index.contains("0")
                                ? dto.addressSend
                                : dto.addressReceive),
                        overflow: TextOverflow.visible,
                        style: TextStyle(color: Colors.black, fontSize: 18),
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      "assets/icons/delivery-truck-svgrepo-com.svg",
                      color: Colors.green[800],
                      height: 20,
                    ),
                    Container(
                      width: getProportionateScreenWidth(200),
                      child: Text(
                        " " + dto.status,
                        overflow: TextOverflow.visible,
                        style: TextStyle(color: Colors.black, fontSize: 18),
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        Wrap(
          spacing: 5,
          runSpacing: 5,
          direction: Axis.horizontal,
          alignment: WrapAlignment.end,
          children: [
            if (widget.index.contains("0"))
              OutlineButton(
                  child: Text("Get product"),
                  textColor: primaryColor,
                  borderSide: BorderSide(color: primaryColor),
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  onPressed: () {
                    _deliveryPresenter.onLoad(dto.idTransport);
                    setState(() {
                      isLoading = true;
                    });
                  }),
            if (widget.index.contains("1"))
              OutlineButton(
                  child: Text("Update"),
                  textColor: primaryColor,
                  borderSide: BorderSide(color: primaryColor),
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  onPressed: () {
                    _settingRefundModalBottomSheet(context, dto.idTransport);
                  }),
            if (widget.index.contains("1"))
              OutlineButton(
                  child: Text("Delivered"),
                  textColor: Colors.green[800],
                  borderSide: BorderSide(color: Colors.green[800]),
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  onPressed: () {
                    _successPresenter.onLoad(dto.idTransport);
                    setState(() {
                      isLoading = true;
                    });
                  })
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

  Widget imageR(Delivery dto) {
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
                // onProductSelected(dto.productExchange.idProduct);
              },
              child: dto.imageProduct.isNotEmpty
                  ? Image.network(dto.imageProduct[0].address)
                  : Image.asset("assets/images/not.png")),
        ),
      ),
    );
  }

  @override
  void onLoadDeliveryError(String error) {
    Fake.showErrorDialog(error, "Error", context);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void onLoadDeliverySuccess(List<Delivery> list) {
    if (list != null) {
      setState(() {
        _list = list;
        isLoading = false;
      });
    }
  }

  @override
  void onDeliveryError(String e) {
    Fake.showErrorDialog(e, "Error", context);
  }

  @override
  void onDeliverySuccess(String s) {
    Fake.showErrorDialog(s, "Notification", context);
    _loadDeliveryPresenter.onLoad(widget.url);
    setState(() {
      isLoading = true;
    });
  }

  @override
  void onDelicerySE(String e) {
    Fake.showErrorDialog(e, "Error", context);
  }

  @override
  void onDeliverySS(String s) {
    Fake.showErrorDialog(s, "Notification", context);
    _loadDeliveryPresenter.onLoad(widget.url);
    setState(() {
      isLoading = true;
    });
  }

  Function reload() {
    _loadDeliveryPresenter.onLoad(widget.url);
    setState(() {
      isLoading = true;
    });
  }

  void _settingRefundModalBottomSheet(context, int idTranport) {
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
                        'Update Status',
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
                      'Input Status',
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
                                    bottom:
                                        MediaQuery.of(bc).viewInsets.bottom),
                                child: contentForm(),
                              ),
                              SizedBox(
                                height: 70,
                              ),
                              // imageWidgets()
                            ],
                          ),
                  ),
                  if (isLoading == false) submitButtom(context, idTranport)
                ],
              ),
            ),
          );
        }).then((_) => reload);
  }

  Widget submitButtom(BuildContext context, int idTranport) {
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

            _presenter.onLoad(idTranport, reason);
            setState(() {
              isLoading = true;
            });
          }

          // close(context);
        },
      ),
    );
  }

  Widget contentForm() {
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
            return "Content is empty";
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: "Status",
          hintText: "Enter your Content",
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

  @override
  void onUpdateError(String e) {
    Fake.showErrorDialog(e, "Error", context);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void onUpdateSuccess(String success) {
    Fake.showDiaglog(context, "Success");
    Navigator.pop(context);
    _loadDeliveryPresenter.onLoad(widget.url);
  }
}
