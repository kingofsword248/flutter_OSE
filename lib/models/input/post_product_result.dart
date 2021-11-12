import 'package:old_change_app/models/product_real.dart';

class PostProductResult {
  String message;
  Product data;

  PostProductResult({this.message, this.data});

  PostProductResult.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new Product.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}
