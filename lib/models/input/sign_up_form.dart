class SignUpFormDTO {
  String userName;
  String password;
  String address;
  String phone;
  String fullName;
  String gender;
  String dob;
  String avatar;

  SignUpFormDTO(
      {this.userName,
      this.password,
      this.address,
      this.phone,
      this.fullName,
      this.gender,
      this.dob,
      this.avatar});

  SignUpFormDTO.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    password = json['password'];
    address = json['address'];
    phone = json['phone'];
    fullName = json['fullName'];
    gender = json['gender'];
    dob = json['dob'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userName'] = this.userName;
    data['password'] = this.password;
    data['address'] = this.address;
    data['phone'] = this.phone;
    data['fullName'] = this.fullName;
    data['gender'] = this.gender;
    data['dob'] = this.dob;
    data['avatar'] = this.avatar;
    return data;
  }
}
