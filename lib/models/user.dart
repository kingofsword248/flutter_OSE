class User {
  int id;
  String userName;
  String role;
  String address;
  String avatar;
  String phone;
  String fullName;
  String gender;
  String dob;
  String createdAt;
  String updatedAt;
  String token;
  int balance;

  User(
      {this.id,
      this.userName,
      this.role,
      this.address,
      this.avatar,
      this.phone,
      this.fullName,
      this.gender,
      this.dob,
      this.createdAt,
      this.updatedAt,
      this.token,
      this.balance});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['userName'];
    role = json['role'];
    address = json['address'];
    avatar = json['avatar'];
    phone = json['phone'];
    fullName = json['fullName'];
    gender = json['gender'];
    dob = json['dob'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    token = json['token'];
    balance = json['balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userName'] = this.userName;
    data['role'] = this.role;
    data['address'] = this.address;
    data['avatar'] = this.avatar;
    data['phone'] = this.phone;
    data['fullName'] = this.fullName;
    data['gender'] = this.gender;
    data['dob'] = this.dob;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['token'] = this.token;
    data['balance'] = this.balance;
    return data;
  }
}

class Userr {
  int id;
  String fullName;
  String userName;
  String avatar;
  String phone;
  String address;
  int balance;
  String role;

  Userr(
      {this.id,
      this.fullName,
      this.userName,
      this.avatar,
      this.phone,
      this.address,
      this.balance,
      this.role});

  Userr.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['fullName'];
    userName = json['userName'];
    avatar = json['avatar'];
    phone = json['phone'];
    address = json['address'];
    balance = json['balance'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fullName'] = this.fullName;
    data['userName'] = this.userName;
    data['avatar'] = this.avatar;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['balance'] = this.balance;
    data['role'] = this.role;
    return data;
  }
}
