class PriceSuggest {
  String priceSuggest;

  PriceSuggest({this.priceSuggest});

  PriceSuggest.fromJson(Map<String, dynamic> json) {
    priceSuggest = json['priceSuggest'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['priceSuggest'] = this.priceSuggest;
    return data;
  }
}
