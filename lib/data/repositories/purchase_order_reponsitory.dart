import 'dart:convert';

import 'package:old_change_app/models/purchase_dto.dart';
import 'package:http/http.dart' as http;

abstract class PurchaseOrderRepository {
  Future<List<PurchaseDTO>> getPurchase(int id, String status, String model);
}

class PurchaseOrderRepositoryIml implements PurchaseOrderRepository {
  List<PurchaseDTO> parsePurchaseDTO(String responseBody) {
    final parsed = json.decode(responseBody);
    return parsed
        .map<PurchaseDTO>((json) => PurchaseDTO.fromJson(json))
        .toList();
  }

  @override
  Future<List<PurchaseDTO>> getPurchase(
      int id, String status, String model) async {
    String url =
        "https://old-stuff-exchange-api.herokuapp.com/api/order/mobile/${model}/?id=${id}&status=${status}";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return parsePurchaseDTO(response.body);
    } else {
      throw Exception("Some thing went wrong");
    }
  }
}
