import 'dart:convert';

import 'package:old_change_app/models/refund.dart';
import 'package:http/http.dart' as http;

abstract class RefundSellRepository {
  Future<List<RefundDTO>> loadRefundP(int id);
}

class RefundSellRepositoryIml implements RefundSellRepository {
  List<RefundDTO> parseProducts(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<RefundDTO>((json) => RefundDTO.fromJson(json)).toList();
  }

  @override
  Future<List<RefundDTO>> loadRefundP(int id) async {
    String url =
        "https://old-stuff-exchange-api.herokuapp.com/api/refund/getListRefundSeller/";
    try {
      Map data = {"id": "$id"};
      final reponse = await http.post(Uri.parse(url), body: data);
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
