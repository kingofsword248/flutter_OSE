import 'package:flutter/material.dart';
import 'package:old_change_app/constants/colors.dart';
import 'package:old_change_app/models/providers/cart_item.dart';
import 'package:old_change_app/models/product_real.dart';
import 'package:provider/provider.dart';
import 'package:smart_select/smart_select.dart';

class AddCart extends StatelessWidget {
  final Product product;
  const AddCart({Key key, @required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartList>(context, listen: false);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.only(right: 10),
              height: 60,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      elevation: 0,
                      primary: Colors.amber),
                  onPressed: () {
                    cart.addItem(product);
                    final snackbar =
                        SnackBar(content: Text("Add to cart successfull"));
                    ScaffoldMessenger.of(context).showSnackBar(snackbar);
                  },
                  child: Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Text('Add To Cart'),
                      Icon(Icons.add_shopping_cart_outlined)
                    ],
                  )),
            ),
          ),
          Expanded(
            child: Container(
              height: 60,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      elevation: 0,
                      primary: Colors.amber),
                  onPressed: () {
                    _showOption(context);
                  },
                  child: Row(
                    children: [
                      SizedBox(
                        width: 40,
                      ),
                      Text('Trade'),
                      Icon(Icons.change_circle_outlined)
                    ],
                  )),
            ),
          )
        ],
      ),
    );
  }

  void close(context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }

  void _showOption(BuildContext context) {
    String value = 'ion';
    List<S2Choice<String>> options = [
      S2Choice<String>(value: 'ion', title: 'Ionic'),
      S2Choice<String>(value: 'flu', title: 'Flutter'),
      S2Choice<String>(value: 'rea', title: 'React Native'),
    ];
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        context: context,
        builder: (BuildContext bc) {
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
                      title: 'Select the product you want to exchange',
                      value: value,
                      onChange: (state) => value = state.value,
                      choiceItems: options,
                      modalType: S2ModalType.popupDialog,
                    ),
                  if (options.isEmpty)
                    const Text(
                      'You dont have any product to trade',
                      textAlign: TextAlign.center,
                    ),
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
                        'Request to Trade',
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
        });
  }
}
