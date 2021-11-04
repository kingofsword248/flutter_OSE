import 'package:flutter/cupertino.dart';
import 'package:old_change_app/models/product_real.dart';

class CartModels {
  final Product product;
  int numOfItems;

  CartModels(this.product, this.numOfItems);
}

class CartList with ChangeNotifier {
  // ignore: prefer_final_fields
  List<CartModels> _carts = [];
  List<CartModels> get carts {
    return _carts;
  }

  int get itemCount {
    return _carts.length;
  }

  bool check(int id) {
    for (int i = 0; i < _carts.length; i++) {
      if (_carts[i].product.idProduct == id) {
        _carts[i].numOfItems = _carts[i].numOfItems + 1;
        return true;
      }
    }
    return false;
  }

  void addItem(Product product) {
    if (!check(product.idProduct)) {
      _carts.add(CartModels(product, 1));
    }
    notifyListeners();
  }

  int sum() {
    int total = 0;
    if (carts.isEmpty) return 0;
    for (int i = 0; i < carts.length; i++) {
      total = total + carts[i].product.price * carts[i].numOfItems;
    }
    return total;
  }

  void removeAtIndex(int index) {
    _carts.removeAt(index);
    notifyListeners();
  }

  void addQuantity(int index) {
    if (_carts[index].numOfItems < _carts[index].product.quantity) {
      _carts[index].numOfItems++;
      notifyListeners();
    }
  }

  void reduceQuantity(int index) {
    if (_carts[index].numOfItems > 1) {
      _carts[index].numOfItems--;
      notifyListeners();
    }
  }

  int sumOfOneItem(int index) {
    return _carts[index].numOfItems * _carts[index].product.price;
  }
}
