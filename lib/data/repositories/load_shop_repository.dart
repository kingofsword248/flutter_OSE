import 'dart:convert';

import 'package:old_change_app/models/info.dart';
import 'package:http/http.dart' as http;

abstract class LoadShopRepository {
  Future<Info> loadShop(int id);
}

class LoadShopRepositoryIml implements LoadShopRepository {
  @override
  Future<Info> loadShop(int id) async {
    String url =
        "https://old-stuff-exchange-api.herokuapp.com/api/users/userProfile";
    Map map = {"id": "$id"};
    final response = await http.post(Uri.parse(url), body: map);
    if (response.statusCode == 200) {
      return Info.fromJson(json.decode(response.body));
    } else {
      throw Exception("Error");
    }
  }
}
