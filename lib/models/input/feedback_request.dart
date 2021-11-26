import 'package:old_change_app/models/input/product_form.dart';

class FeedbackRequest {
  String reason;
  int idOrderDetail;
  List<ImageP> image;

  FeedbackRequest({this.reason, this.idOrderDetail, this.image});

  FeedbackRequest.fromJson(Map<String, dynamic> json) {
    reason = json['reason'];
    idOrderDetail = json['idOrderDetail'];
    if (json['image'] != null) {
      image = new List<ImageP>();
      json['image'].forEach((v) {
        image.add(new ImageP.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reason'] = this.reason;
    data['idOrderDetail'] = this.idOrderDetail;
    if (this.image != null) {
      data['image'] = this.image.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
