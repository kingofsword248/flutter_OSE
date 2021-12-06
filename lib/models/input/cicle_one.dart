class CircleOne {
  String tradeMappingCode;
  int peopleInCircle;
  List<ListProductInCircle> listProductInCircle;

  CircleOne(
      {this.tradeMappingCode, this.peopleInCircle, this.listProductInCircle});

  CircleOne.fromJson(Map<String, dynamic> json) {
    tradeMappingCode = json['tradeMappingCode'];
    peopleInCircle = json['peopleInCircle'];
    if (json['listProductInCircle'] != null) {
      listProductInCircle = new List<ListProductInCircle>();
      json['listProductInCircle'].forEach((v) {
        listProductInCircle.add(new ListProductInCircle.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tradeMappingCode'] = this.tradeMappingCode;
    data['peopleInCircle'] = this.peopleInCircle;
    if (this.listProductInCircle != null) {
      data['listProductInCircle'] =
          this.listProductInCircle.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ListProductInCircle {
  int idTradeMapping;
  int fromRequestID;
  int toRequestID;
  String status;
  int idRequest;
  int idProduct;
  String name;
  int price;
  int own;
  String fullName;
  String avatar;
  List<ImageProduct> imageProduct;

  ListProductInCircle(
      {this.idTradeMapping,
      this.fromRequestID,
      this.toRequestID,
      this.status,
      this.idRequest,
      this.idProduct,
      this.name,
      this.price,
      this.own,
      this.fullName,
      this.avatar,
      this.imageProduct});

  ListProductInCircle.fromJson(Map<String, dynamic> json) {
    idTradeMapping = json['idTradeMapping'];
    fromRequestID = json['fromRequestID'];
    toRequestID = json['toRequestID'];
    status = json['status'];
    idRequest = json['idRequest'];
    idProduct = json['idProduct'];
    name = json['name'];
    price = json['price'];
    own = json['own'];
    fullName = json['fullName'];
    avatar = json['avatar'];
    if (json['imageProduct'] != null) {
      imageProduct = new List<ImageProduct>();
      json['imageProduct'].forEach((v) {
        imageProduct.add(new ImageProduct.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idTradeMapping'] = this.idTradeMapping;
    data['fromRequestID'] = this.fromRequestID;
    data['toRequestID'] = this.toRequestID;
    data['status'] = this.status;
    data['idRequest'] = this.idRequest;
    data['idProduct'] = this.idProduct;
    data['name'] = this.name;
    data['price'] = this.price;
    data['own'] = this.own;
    data['fullName'] = this.fullName;
    data['avatar'] = this.avatar;
    if (this.imageProduct != null) {
      data['imageProduct'] = this.imageProduct.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ImageProduct {
  String address;

  ImageProduct({this.address});

  ImageProduct.fromJson(Map<String, dynamic> json) {
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    return data;
  }
}
