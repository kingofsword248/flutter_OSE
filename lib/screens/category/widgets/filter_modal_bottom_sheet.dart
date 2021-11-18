// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:old_change_app/constants/colors.dart';
import 'package:old_change_app/models/category.dart';
import 'package:old_change_app/screens/category/widgets/fliter_list.dart';
import 'package:smart_select/smart_select.dart';

class FilterModalBottomSheet extends StatelessWidget {
  final List<Categories> list;

  const FilterModalBottomSheet({Key key, @required this.list})
      : super(key: key);

  void close(context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }

  SmartSelect categoryForm() {
    // List<S2Choice<String>> options = [
    //   S2Choice<String>(value: 'BOTH', title: 'Sell and Exchange'),
    //   S2Choice<String>(value: 'SELL', title: 'Sell'),
    //   S2Choice<String>(value: 'EXCHANGE', title: 'Exchange'),
    // ];
    List<S2Choice<String>> options = list
        .map((e) =>
            S2Choice<String>(value: e.idcategory.toString(), title: e.name))
        .toList();

    return SmartSelect.single(
        title: "Category",
        modalTitle: "",
        value: null,
        onChange: (state) {
          // checkCategoryChange(state.value);
        },
        choiceItems: options,
        modalType: S2ModalType.fullPage);
  }

  SmartSelect TransactionForm() {
    List<S2Choice<String>> options = [
      S2Choice<String>(value: 'BOTH', title: 'Sell and Exchange'),
      S2Choice<String>(value: 'SELL', title: 'Sell'),
      S2Choice<String>(value: 'EXCHANGE', title: 'Exchange'),
      S2Choice<String>(value: 'All', title: 'ALL'),
    ];

    return SmartSelect.single(
        title: "Type of Transaction",
        value: 'All',
        onChange: (state) {
          // checkCategoryChange(state.value);
        },
        choiceItems: options,
        modalType: S2ModalType.bottomSheet);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(28),
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
                  'Filter',
                  textAlign: TextAlign.center,
                ),
                Container(
                  width: 100,
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () {},
                    child: Text(
                      'Reset',
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
                'Price Range',
                style: TextStyle(fontSize: 20),
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(top: 20),
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                alignment: WrapAlignment.spaceBetween,
                children: [
                  Container(
                    width: ((size.width / 2) - 55),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black12, width: 1)),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        hintText: 'Minimun',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Container(
                    width: 15,
                    height: 1,
                    color: Colors.black38,
                  ),
                  Container(
                    width: ((size.width / 2) - 55),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black12, width: 1)),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        hintText: 'Maximun',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                'Item Filter',
                style: TextStyle(fontSize: 20),
              ),
            ),
            categoryForm(),
            SizedBox(
              height: 10,
            ),
            TransactionForm(),
            // ignore: avoid_unnecessary_containers
            // Container(
            //   child: FilterList(onSelect: (selected) => print(selected)),
            // ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(vertical: 20),
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7)),
                textColor: Colors.white,
                color: primaryColor,
                padding: EdgeInsets.all(20),
                child: Text(
                  'Apply Filter',
                  style: TextStyle(fontSize: 16),
                ),
                onPressed: () {
                  close(context);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
