class ProductPost {
  String name;
  String description;
  int quantity;
  int price;
  List<Image> image;
  int own;
  String status;
  int categoryID;
  int categoryChangeID;

  ProductPost(
      {this.name,
      this.description,
      this.quantity,
      this.price,
      this.image,
      this.own,
      this.status,
      this.categoryID,
      this.categoryChangeID});

  ProductPost.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    quantity = json['quantity'];
    price = json['price'];
    if (json['image'] != null) {
      image = new List<Image>();
      json['image'].forEach((v) {
        image.add(new Image.fromJson(v));
      });
    }
    own = json['own'];
    status = json['status'];
    categoryID = json['categoryID'];
    categoryChangeID = json['categoryChangeID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['description'] = this.description;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    if (this.image != null) {
      data['image'] = this.image.map((v) => v.toJson()).toList();
    }
    data['own'] = this.own;
    data['status'] = this.status;
    data['categoryID'] = this.categoryID;
    data['categoryChangeID'] = this.categoryChangeID;
    return data;
  }
}

class Image {
  String url;

  Image({this.url});

  Image.fromJson(Map<String, dynamic> json) {
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    return data;
  }
}
