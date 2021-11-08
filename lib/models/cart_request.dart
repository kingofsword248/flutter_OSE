import 'package:old_change_app/models/providers/cart_item.dart';

class CartRequest {
  int id;
  List<ProductRequest> product;

  CartRequest({this.id, this.product});

  factory CartRequest.fromJson(Map<String, dynamic> json) {
    // var list = json['product'] as List;
    // List<ProductRequest> productList =
    //     list.map((i) => ProductRequest.fromJson(i)).toList();
    return CartRequest(
      id: json['id'] as int,
      product: List<ProductRequest>.from(
          json["product"].map((x) => ProductRequest.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (product != null) {
      data['product'] = product.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductRequest {
  int idproduct;
  int quantity;

  ProductRequest({this.idproduct, this.quantity});

  factory ProductRequest.fromJson(Map<String, dynamic> json) {
    return ProductRequest(
        idproduct: json['idproduct'], quantity: json['quantity']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idproduct'] = idproduct;
    data['quantity'] = quantity;
    return data;
  }
}

class Result {
  String result;

  Result({this.result});

  Result.fromJson(Map<String, dynamic> json) {
    result = json['result'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    return data;
  }
}
