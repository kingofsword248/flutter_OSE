import 'dart:convert';

import 'package:old_change_app/models/input/feedback_form.dart';
import 'package:http/http.dart' as http;

abstract class LoadFeedbackRepository {
  Future<FeedbackForm> loadFeedback(int id);
}

class LoadFeedbackRepositoryIml implements LoadFeedbackRepository {
  @override
  Future<FeedbackForm> loadFeedback(int id) async {
    String uri =
        "https://old-stuff-exchange-api.herokuapp.com/api/feedback/listFeedback/$id";
    try {
      final response = await http.get(Uri.parse(uri));
      if (response.statusCode == 200) {
        return FeedbackForm.fromJson(json.decode(response.body));
      } else {
        throw Exception(response.body);
      }
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }
}
