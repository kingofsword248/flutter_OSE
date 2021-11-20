import 'package:old_change_app/models/input/product_form.dart';

class ReviewsForm {
  int productId;
  String content;
  List<ImageP> image;
  double star;

  ReviewsForm({this.productId, this.content, this.image, this.star});

  ReviewsForm.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    content = json['content'];
    if (json['image'] != null) {
      image = new List<ImageP>();
      json['image'].forEach((v) {
        image.add(new ImageP.fromJson(v));
      });
    }
    star = json['star'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productId'] = this.productId;
    data['content'] = this.content;
    if (this.image != null) {
      data['image'] = this.image.map((v) => v.toJson()).toList();
    }
    data['star'] = this.star;
    return data;
  }
}
