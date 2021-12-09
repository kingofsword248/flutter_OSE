class RefundDTO {
  int idOrderDetail;
  int quantity;
  int price;
  String description;
  Product product;
  String reasonRefund;
  List<Images> imageRefund;
  List<User> user;
  String date;
  String timeLimitAccept;
  String transport;
  String status;

  RefundDTO(
      {this.idOrderDetail,
      this.quantity,
      this.price,
      this.description,
      this.product,
      this.reasonRefund,
      this.imageRefund,
      this.user,
      this.date,
      this.timeLimitAccept,
      this.transport,
      this.status});

  RefundDTO.fromJson(Map<String, dynamic> json) {
    idOrderDetail = json['idOrderDetail'];
    quantity = json['quantity'];
    price = json['price'];
    description = json['description'];
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
    reasonRefund = json['reasonRefund'];
    if (json['imageRefund'] != null) {
      imageRefund = new List<Images>();
      json['imageRefund'].forEach((v) {
        imageRefund.add(new Images.fromJson(v));
      });
    }
    if (json['user'] != null) {
      user = new List<User>();
      json['user'].forEach((v) {
        user.add(new User.fromJson(v));
      });
    }
    date = json['date'];
    timeLimitAccept = json['timeLimitAccept'];
    transport = json['transport'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idOrderDetail'] = this.idOrderDetail;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['description'] = this.description;
    if (this.product != null) {
      data['product'] = this.product.toJson();
    }
    data['reasonRefund'] = this.reasonRefund;
    if (this.imageRefund != null) {
      data['imageRefund'] = this.imageRefund.map((v) => v.toJson()).toList();
    }
    if (this.user != null) {
      data['user'] = this.user.map((v) => v.toJson()).toList();
    }
    data['date'] = this.date;
    data['timeLimitAccept'] = this.timeLimitAccept;
    data['transport'] = this.transport;
    data['status'] = this.status;
    return data;
  }
}

class Product {
  int idProduct;
  String name;
  List<Images> images;

  Product({this.idProduct, this.name, this.images});

  Product.fromJson(Map<String, dynamic> json) {
    idProduct = json['idProduct'];
    name = json['name'];
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

class User {
  int id;
  String fullName;
  String avatar;

  User({this.id, this.fullName, this.avatar});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['fullName'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fullName'] = this.fullName;
    data['avatar'] = this.avatar;
    return data;
  }
}
