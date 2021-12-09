import 'dart:ffi';

import 'package:old_change_app/models/product_real.dart';

class Info {
  int id;
  String starUser;
  String fullName;
  String userName;
  String avatar;
  String phone;
  String address;
  String role;
  List<Product> listProduct;

  Info(
      {this.id,
      this.starUser,
      this.fullName,
      this.userName,
      this.avatar,
      this.phone,
      this.address,
      this.role,
      this.listProduct});

  Info.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    starUser = json['starUser'].toString();
    fullName = json['fullName'];
    userName = json['userName'];
    avatar = json['avatar'];
    phone = json['phone'];
    address = json['address'];
    role = json['role'];
    if (json['listProduct'] != null) {
      listProduct = new List<Product>();
      json['listProduct'].forEach((v) {
        listProduct.add(new Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['starUser'] = this.starUser;
    data['fullName'] = this.fullName;
    data['userName'] = this.userName;
    data['avatar'] = this.avatar;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['role'] = this.role;
    if (this.listProduct != null) {
      data['listProduct'] = this.listProduct.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
