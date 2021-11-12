class Product {
  int idProduct;
  String name;
  String description;
  int quantity;
  int price;
  String status;
  int own;
  String createdAt;
  String updatedAt;
  int brandID;
  int categoryID;
  List<Images> images;

  Product(
      {this.idProduct,
      this.name,
      this.description,
      this.quantity,
      this.price,
      this.status,
      this.own,
      this.createdAt,
      this.updatedAt,
      this.brandID,
      this.categoryID,
      this.images});

  Product.fromJson(Map<String, dynamic> json) {
    idProduct = json['idProduct'];
    name = json['name'];
    description = json['description'];
    quantity = json['quantity'];
    price = json['price'];
    status = json['status'];
    own = json['own'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    brandID = json['brandID'];
    categoryID = json['categoryID'];
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
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['brandID'] = this.brandID;
    data['categoryID'] = this.categoryID;
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
