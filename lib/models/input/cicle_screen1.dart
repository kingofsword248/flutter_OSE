class CircleHome {
  Product product;
  String statusRequestProduct;

  CircleHome({this.product, this.statusRequestProduct});

  CircleHome.fromJson(Map<String, dynamic> json) {
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
    statusRequestProduct = json['statusRequestProduct'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.product != null) {
      data['product'] = this.product.toJson();
    }
    data['statusRequestProduct'] = this.statusRequestProduct;
    return data;
  }
}

class Product {
  int idProduct;
  String name;
  String description;
  int quantity;
  int price;
  String status;
  List<Images> images;

  Product(
      {this.idProduct,
      this.name,
      this.description,
      this.quantity,
      this.price,
      this.status,
      this.images});

  Product.fromJson(Map<String, dynamic> json) {
    idProduct = json['idProduct'];
    name = json['name'];
    description = json['description'];
    quantity = json['quantity'];
    price = json['price'];
    status = json['status'];
    if (json['images'] != null) {
      images = new List<Images>();
      json['images'].forEach((v) {
        images.add(new Images.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idProduct'] = this.idProduct;
    data['name'] = this.name;
    data['description'] = this.description;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['status'] = this.status;
    if (this.images != null) {
      data['images'] = this.images.map((v) => v.toJson()).toList();
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
