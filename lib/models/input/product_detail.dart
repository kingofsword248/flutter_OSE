import 'package:old_change_app/models/product_real.dart';

class ProductDetail {
  int idProduct;
  String description;
  int quantity;
  String name;
  int price;
  String status;
  int own;
  String avatar;
  String fullName;
  int categoryID;
  String createdAt;
  String updatedAt;
  int brandID;
  List<Images> images;

  ProductDetail(
      {this.idProduct,
      this.description,
      this.quantity,
      this.name,
      this.price,
      this.status,
      this.own,
      this.avatar,
      this.fullName,
      this.categoryID,
      this.createdAt,
      this.updatedAt,
      this.brandID,
      this.images});

  ProductDetail.fromJson(Map<String, dynamic> json) {
    idProduct = json['idProduct'];
    description = json['description'];
    quantity = json['quantity'];
    name = json['name'];
    price = json['price'];
    status = json['status'];
    own = json['own'];
    avatar = json['avatar'];
    fullName = json['fullName'];
    categoryID = json['categoryID'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    brandID = json['brandID'];
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
    data['description'] = this.description;
    data['quantity'] = this.quantity;
    data['name'] = this.name;
    data['price'] = this.price;
    data['status'] = this.status;
    data['own'] = this.own;
    data['avatar'] = this.avatar;
    data['fullName'] = this.fullName;
    data['categoryID'] = this.categoryID;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['brandID'] = this.brandID;
    if (this.images != null) {
      data['Images'] = this.images.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

// class Images {
//   String address;

//   Images({this.address});

//   Images.fromJson(Map<String, dynamic> json) {
//     address = json['address'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['address'] = this.address;
//     return data;
//   }
// }
