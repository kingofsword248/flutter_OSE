import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:old_change_app/models/input/post_image_result.dart';
import 'package:http_parser/http_parser.dart';

abstract class LoadImageRepository {
  Future<ImageResult> fetchImage(File file);
}

class LoadImageRepositoryIml implements LoadImageRepository {
  @override
  Future<ImageResult> fetchImage(File file) async {
    String url =
        "https://old-stuff-exchange-api.herokuapp.com/api/products/image";
    String fileName = file.path.split('/').last;
    String dui = file.path.split(".").last;
    FormData formData = FormData.fromMap({
      "image": await MultipartFile.fromFile(file.path,
          filename: fileName, contentType: MediaType('image', dui)),
      "type": "image/*"
    });
    var dio = Dio();

    final reponse = await dio.post(url, data: formData);
    if (reponse.statusCode == 200) {
      // print(reponse.data.toString());
      return ImageResult.fromJson(reponse.data);
    } else {
      throw Exception("load Image error");
    }
  }
}
