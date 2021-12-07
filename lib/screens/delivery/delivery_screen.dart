import 'package:flutter/material.dart';
import 'package:old_change_app/screens/delivery/delivery_tap.dart';
import 'package:old_change_app/screens/purchase_order/tap/confirm_screen/confirm_tap.dart';
import 'package:old_change_app/screens/purchase_order/tap/confirm_screen/confirm_trade_tap.dart';
import 'package:old_change_app/screens/purchase_order/tap/delivery_screen/delivery_tap.dart';
import 'package:old_change_app/screens/purchase_order/tap/refund/return_tap.dart';
import 'package:old_change_app/screens/sign_in/sign_in_screen.dart';
import 'package:old_change_app/utilities/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeliveryScreen extends StatefulWidget {
  const DeliveryScreen({Key key}) : super(key: key);

  @override
  _DeliveryScreenState createState() => _DeliveryScreenState();
}

class _DeliveryScreenState extends State<DeliveryScreen>
    with TickerProviderStateMixin {
  // late TabController _tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _tabController = TabController(length: 6, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: const Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Text(
                "Delivery Application",
                style: TextStyle(color: Colors.black),
              ),
            ),
            actions: [
              IconButton(
                  onPressed: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.clear().then((value) {
                      if (value)
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignInScreen()));
                    });
                  },
                  icon: Icon(
                    Icons.exit_to_app_rounded,
                    color: Colors.black,
                  ))
            ],
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () => {},
            ),
            backgroundColor: Colors.white,
            centerTitle: true,
            elevation: 0,
            bottom: const TabBar(
              isScrollable: true,
              indicatorColor: primaryColor,
              indicatorWeight: 4,
              labelColor: primaryColor,
              tabs: [
                Tab(
                  child: Text("Orders waiting for pick up",
                      style: TextStyle(color: Colors.black, fontSize: 18.0)),
                ),
                Tab(
                  child: Text("Delivery is in progress",
                      style: TextStyle(color: Colors.black, fontSize: 18.0)),
                ),
                Tab(
                  child: Text("Delivered",
                      style: TextStyle(color: Colors.black, fontSize: 18.0)),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              DeliveryTap2(
                index: "0",
                url:
                    "https://old-stuff-exchange-api.herokuapp.com/api/transport/listDelivery",
              ),
              DeliveryTap2(
                index: "1",
                url:
                    "https://old-stuff-exchange-api.herokuapp.com/api/transport/listDeliveryToUpdateStatus",
              ),
              DeliveryTap2(
                index: "2",
                url:
                    "https://old-stuff-exchange-api.herokuapp.com/api/transport/listDeliverySuccess",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
