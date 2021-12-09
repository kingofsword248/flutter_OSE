class Category2 {
  String iconPath;
  String title;
  Category2(this.iconPath, this.title);
}

class Category {
  int idbrand;
  String brandname;
  List<Categories> categories;

  Category({this.idbrand, this.brandname, this.categories});

  Category.fromJson(Map<String, dynamic> json) {
    idbrand = json['idbrand'];
    brandname = json['brandname'];
    if (json['categories'] != null) {
      categories = new List<Categories>();
      json['categories'].forEach((v) {
        categories.add(new Categories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idbrand'] = this.idbrand;
    data['brandname'] = this.brandname;
    if (this.categories != null) {
      data['categories'] = this.categories.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Categories {
  int idcategory;
  String name;

  Categories({this.idcategory, this.name});

  Categories.fromJson(Map<String, dynamic> json) {
    idcategory = json['idcategory'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idcategory'] = this.idcategory;
    data['name'] = this.name;
    return data;
  }
}
