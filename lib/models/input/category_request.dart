class CategoryRequest {
  int idcategory;
  String name;
  String brandname;

  CategoryRequest({this.idcategory, this.name, this.brandname});

  CategoryRequest.fromJson(Map<String, dynamic> json) {
    idcategory = json['idcategory'];
    name = json['name'];
    brandname = json['brandname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idcategory'] = this.idcategory;
    data['name'] = this.name;
    data['brandname'] = this.brandname;
    return data;
  }

  static List<Map<String, dynamic>> convert(List<CategoryRequest> list) {
    List<Map<String, dynamic>> data = [];
    for (var i = 0; i < list.length; i++) {
      data.add(list[i].toJson());
    }
    return data;
  }
}
