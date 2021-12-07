import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:old_change_app/models/delivery.dart';
import 'package:old_change_app/presenters/deliveru_presenter.dart';
import 'package:old_change_app/presenters/delivery_success_presenter.dart';
import 'package:old_change_app/presenters/load_delivery_presenter.dart';
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
    implements LoadDeliveryContract, DeliveryContract, DeliverySuccessContract {
  bool isLoading = true;
  List<Delivery> _list = [];
  LoadDeliveryPresenter _loadDeliveryPresenter;
  DeliveryPresenter _deliveryPresenter;
  DeliverySuccessPresenter _successPresenter;
  // User _user;

  // Future<Null> getSharedPrefs() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String user = prefs.get('User');
  //   _user = User.fromJson(json.decode(user));
  // }

  @override
  void initState() {
    // TODO: implement initState
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

  void _settingRefundModalBottomSheet(context, int idTranport) {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        context: context,
        builder: (BuildContext bc) {
          return DeliveryModalBottomSheet(
            idTransport: idTranport,
          );
        });
  }
}
