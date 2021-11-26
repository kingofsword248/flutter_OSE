import 'package:old_change_app/models/input/exchange_result_list.dart';

class FeedbackForm {
  double aVGStar;
  List<ListFeedback> listFeedback;

  FeedbackForm({this.aVGStar, this.listFeedback});

  FeedbackForm.fromJson(Map<String, dynamic> json) {
    aVGStar = json['AVGStar'].toDouble();
    if (json['listFeedback'] != null) {
      listFeedback = new List<ListFeedback>();
      json['listFeedback'].forEach((v) {
        listFeedback.add(new ListFeedback.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AVGStar'] = this.aVGStar;
    if (this.listFeedback != null) {
      data['listFeedback'] = this.listFeedback.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ListFeedback {
  int idFeedback;
  String content;
  String date;
  int star;
  int id;
  String fullName;
  String avatar;
  int productId;
  int orderDetailId;
  List<Images> image;

  ListFeedback(
      {this.idFeedback,
      this.content,
      this.date,
      this.star,
      this.id,
      this.fullName,
      this.avatar,
      this.productId,
      this.orderDetailId,
      this.image});

  ListFeedback.fromJson(Map<String, dynamic> json) {
    idFeedback = json['idFeedback'];
    content = json['content'];
    date = json['date'];
    star = json['star'];
    id = json['id'];
    fullName = json['fullName'];
    avatar = json['avatar'];
    productId = json['productId'];
    orderDetailId = json['orderDetailId'];
    if (json['image'] != null) {
      image = new List<Images>();
      json['image'].forEach((v) {
        image.add(new Images.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idFeedback'] = this.idFeedback;
    data['content'] = this.content;
    data['date'] = this.date;
    data['star'] = this.star;
    data['id'] = this.id;
    data['fullName'] = this.fullName;
    data['avatar'] = this.avatar;
    data['productId'] = this.productId;
    data['orderDetailId'] = this.orderDetailId;
    if (this.image != null) {
      data['image'] = this.image.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
