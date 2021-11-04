class Product {
  int idProduct;
  String name;
  String description;
  int quantity;
  int price;
  String status;
  int own;
  int categoryId;
  String createdAt;
  String updatedAt;
  List<Images> images;
  double rating = 0;

  Product(
      {this.idProduct,
      this.name,
      this.description,
      this.quantity,
      this.price,
      this.status,
      this.own,
      this.categoryId,
      this.createdAt,
      this.updatedAt,
      this.images});

  Product.fromJson(Map<String, dynamic> json) {
    idProduct = json['idProduct'];
    name = json['name'];
    description = json['description'];
    quantity = json['quantity'];
    price = json['price'];
    status = json['status'];
    own = json['own'];
    categoryId = json['categoryId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
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
    data['description'] = this.description;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['status'] = this.status;
    data['own'] = this.own;
    data['categoryId'] = this.categoryId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
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
