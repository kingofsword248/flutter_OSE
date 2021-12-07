import 'dart:convert';

import 'package:old_change_app/models/delivery.dart';
import 'package:http/http.dart' as http;

abstract class LoadDeliveryRepository {
  Future<List<Delivery>> getDelivery(String url);
}

class LoadDeliveryPositoryIml implements LoadDeliveryRepository {
  List<Delivery> parseProducts(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Delivery>((json) => Delivery.fromJson(json)).toList();
  }

  @override
  Future<List<Delivery>> getDelivery(String url) async {
    try {
      final reponse = await http.get(Uri.parse(url));
      if (reponse.statusCode == 200) {
        return parseProducts(reponse.body);
      } else {
        throw Exception("Error");
      }
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }
}
