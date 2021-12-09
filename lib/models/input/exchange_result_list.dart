class ExchangeForm {
  int idRequest;
  UserE user;
  Myproduct myproduct;
  ProductExchange productExchange;
  int priceDiff;

  ExchangeForm(
      {this.idRequest,
      this.user,
      this.myproduct,
      this.productExchange,
      this.priceDiff});

  ExchangeForm.fromJson(Map<String, dynamic> json) {
    idRequest = json['idRequest'];
    user = json['user'] != null ? new UserE.fromJson(json['user']) : null;
    myproduct = json['myproduct'] != null
        ? new Myproduct.fromJson(json['myproduct'])
        : null;
    productExchange = json['productExchange'] != null
        ? new ProductExchange.fromJson(json['productExchange'])
        : null;
    priceDiff = json['priceDiff'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idRequest'] = this.idRequest;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    if (this.myproduct != null) {
      data['myproduct'] = this.myproduct.toJson();
    }
    if (this.productExchange != null) {
      data['productExchange'] = this.productExchange.toJson();
    }
    data['priceDiff'] = this.priceDiff;
    return data;
  }
}

class UserE {
  int id;
  String fullName;
  String avatar;

  UserE({this.id, this.fullName, this.avatar});

  UserE.fromJson(Map<String, dynamic> json) {
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

class Myproduct {
  int idProduct;
  String name;
  int price;
  List<Images> images;

  Myproduct({this.idProduct, this.name, this.price, this.images});

  Myproduct.fromJson(Map<String, dynamic> json) {
    idProduct = json['idProduct'];
    name = json['name'];
    price = json['price'];
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
    data['price'] = this.price;
    if (this.images != null) {
      data['images'] = this.images.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductExchange {
  int idProduct;
  String name;
  int price;
  List<Images> images;

  ProductExchange({this.idProduct, this.name, this.price, this.images});

  ProductExchange.fromJson(Map<String, dynamic> json) {
    idProduct = json['idProduct'];
    name = json['name'];
    price = json['price'];
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
    data['price'] = this.price;
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
