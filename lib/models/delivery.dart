class Delivery {
  int idTransport;
  String statusOrder;
  String status;
  int idOrderDetail;
  int requestRefundId;
  int idProduct;
  int quantity;
  String name;
  String fullNameSend;
  String addressSend;
  String phoneSend;
  String fullNameReceive;
  String addressReceive;
  String phoneReceive;
  List<ImageProduct> imageProduct;

  Delivery(
      {this.idTransport,
      this.statusOrder,
      this.status,
      this.idOrderDetail,
      this.requestRefundId,
      this.idProduct,
      this.quantity,
      this.name,
      this.fullNameSend,
      this.addressSend,
      this.phoneSend,
      this.fullNameReceive,
      this.addressReceive,
      this.phoneReceive,
      this.imageProduct});

  Delivery.fromJson(Map<String, dynamic> json) {
    idTransport = json['idTransport'];
    statusOrder = json['statusOrder'];
    status = json['status'];
    idOrderDetail = json['idOrderDetail'];
    requestRefundId = json['requestRefundId'];
    idProduct = json['idProduct'];
    quantity = json['quantity'];
    name = json['name'];
    fullNameSend = json['fullNameSend'];
    addressSend = json['addressSend'];
    phoneSend = json['phoneSend'];
    fullNameReceive = json['fullNameReceive'];
    addressReceive = json['addressReceive'];
    phoneReceive = json['phoneReceive'];
    if (json['imageProduct'] != null) {
      imageProduct = new List<ImageProduct>();
      json['imageProduct'].forEach((v) {
        imageProduct.add(new ImageProduct.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idTransport'] = this.idTransport;
    data['statusOrder'] = this.statusOrder;
    data['status'] = this.status;
    data['idOrderDetail'] = this.idOrderDetail;
    data['requestRefundId'] = this.requestRefundId;
    data['idProduct'] = this.idProduct;
    data['quantity'] = this.quantity;
    data['name'] = this.name;
    data['fullNameSend'] = this.fullNameSend;
    data['addressSend'] = this.addressSend;
    data['phoneSend'] = this.phoneSend;
    data['fullNameReceive'] = this.fullNameReceive;
    data['addressReceive'] = this.addressReceive;
    data['phoneReceive'] = this.phoneReceive;
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
