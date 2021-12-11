class Trending {
  int idProduct;
  String name;
  String description;
  int quantity;
  int price;
  String status;
  int own;
  int categoryID;
  int brandID;
  int star;
  List<Images> images;

  Trending(
      {this.idProduct,
      this.name,
      this.description,
      this.quantity,
      this.price,
      this.status,
      this.own,
      this.categoryID,
      this.brandID,
      this.star,
      this.images});

  Trending.fromJson(Map<String, dynamic> json) {
    idProduct = json['idProduct'];
    name = json['name'];
    description = json['description'];
    quantity = json['quantity'];
    price = json['price'];
    status = json['status'];
    own = json['own'];
    categoryID = json['categoryID'];
    brandID = json['brandID'];
    star = json['star'];
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
    data['own'] = this.own;
    data['categoryID'] = this.categoryID;
    data['brandID'] = this.brandID;
    data['star'] = this.star;
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
