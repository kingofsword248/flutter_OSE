import 'package:flutter/material.dart';
import 'package:old_change_app/constants/colors.dart';
import 'package:old_change_app/screens/purchase_order/tap/confirm_screen/confirm_tap.dart';
import 'package:old_change_app/screens/purchase_order/tap/delivery_screen/delivery_tap.dart';
import 'package:old_change_app/screens/purchase_order/tap/return_tap.dart';
import 'package:old_change_app/screens/sell_order/tap/cofirm_sell_tap.dart';

class SellOrderScreen extends StatefulWidget {
  const SellOrderScreen({Key key}) : super(key: key);

  @override
  _SellOrderScreenState createState() => _SellOrderScreenState();
}

class _SellOrderScreenState extends State<SellOrderScreen>
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
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: AppBar(
          title: const Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Text(
              "My Selling Products",
              style: TextStyle(color: Colors.black),
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () => {
              if (Navigator.canPop(context)) {Navigator.pop(context)}
            },
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
                child: Text("Waiting for confirmation",
                    style: TextStyle(color: Colors.black, fontSize: 18.0)),
              ),
              Tab(
                child: Text("Waiting for delivery",
                    style: TextStyle(color: Colors.black, fontSize: 18.0)),
              ),
              Tab(
                child: Text("Delivery",
                    style: TextStyle(color: Colors.black, fontSize: 18.0)),
              ),
              Tab(
                child: Text("Completed delivery",
                    style: TextStyle(color: Colors.black, fontSize: 18.0)),
              ),
              Tab(
                child: Text("Cancelled",
                    style: TextStyle(color: Colors.black, fontSize: 18.0)),
              ),
              Tab(
                child: Text("Return",
                    style: TextStyle(color: Colors.black, fontSize: 18.0)),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            ConfirmSell(
              index: "1",
            ),
            ConfirmSell(
              index: "2",
            ),
            DeliveryTap(
              index: "3",
            ),
            DeliveryTap(
              index: "4",
            ),
            DeliveryTap(
              index: "5",
            ),
            ReturnTap(),
          ],
        ),
      ),
    );
  }
}
