import 'dart:convert';

import 'package:old_change_app/models/input/exchange_result_list.dart';
import 'package:http/http.dart' as http;

abstract class GetExchangeRequestRepository {
  Future<List<ExchangeForm>> getList(String myID);
}

class GetExchangeRequestRepositoryIml implements GetExchangeRequestRepository {
  List<ExchangeForm> parseProducts(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<ExchangeForm>((json) => ExchangeForm.fromJson(json))
        .toList();
  }

  @override
  Future<List<ExchangeForm>> getList(String myID) async {
    String url =
        "https://old-stuff-exchange-api.herokuapp.com/api/exchange/listRequestWantChangeSeller/$myID";
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return parseProducts(response.body);
      } else {
        throw Exception(response.body);
      }
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }
}
