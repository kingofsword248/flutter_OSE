class PurchaseDTO {
  int idOrderDetail;
  int quantity;
  int price;
  List<Product> product;
  String transport;

  PurchaseDTO(
      {this.idOrderDetail,
      this.quantity,
      this.price,
      this.product,
      this.transport});

  PurchaseDTO.fromJson(Map<String, dynamic> json) {
    idOrderDetail = json['idOrderDetail'];
    quantity = json['quantity'];
    price = json['price'];
    if (json['product'] != null) {
      product = new List<Product>();
      json['product'].forEach((v) {
        product.add(new Product.fromJson(v));
      });
    }
    transport = json['transport'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idOrderDetail'] = this.idOrderDetail;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    if (this.product != null) {
      data['product'] = this.product.map((v) => v.toJson()).toList();
    }
    data['transport'] = this.transport;
    return data;
  }
}

class Product {
  int idProduct;
  String name;
  List<Images> images;

  Product({this.idProduct, this.name, this.images});

  Product.fromJson(Map<String, dynamic> json) {
    idProduct = json['idProduct'];
    name = json['name'];
    if (json['Images'] != null) {
      images = new List<Images>();
      json['Images'].forEach((v) {
        images.add(new Images.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idProduct'] = this.idProduct;
    data['name'] = this.name;
    if (this.images != null) {
      data['Images'] = this.images.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Images {
  String address;

  Images({this.address});

  Images.fromJson(Map<String, dynamic> json) {
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    return data;
  }
}
