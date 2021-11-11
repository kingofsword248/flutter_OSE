class ImageResult {
  String cloudinaryId;
  String url;

  ImageResult({this.cloudinaryId, this.url});

  ImageResult.fromJson(Map<String, dynamic> json) {
    cloudinaryId = json['cloudinaryId'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cloudinaryId'] = this.cloudinaryId;
    data['url'] = this.url;
    return data;
  }
}
