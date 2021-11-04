class CartRequest {
  String id;
  List<ProductRequest> product;

  CartRequest({this.id, this.product});

  CartRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['product'] != null) {
      product = new List<ProductRequest>();
      json['product'].forEach((v) {
        product.add(new ProductRequest.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.product != null) {
      data['product'] = this.product.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductRequest {
  String idproduct;
  String quantity;

  ProductRequest({this.idproduct, this.quantity});

  ProductRequest.fromJson(Map<String, dynamic> json) {
    idproduct = json['idproduct'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idproduct'] = this.idproduct;
    data['quantity'] = this.quantity;
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
