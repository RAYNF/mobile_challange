import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile_test/model/list_user_model.dart';

class ApiService {
  final http.Client client;

  ApiService(this.client);

  static const String endPoint = "https://reqres.in/api";

  Future<ListUserModel> getUsers([int page = 1, int size = 10]) async {
    var url = Uri.parse("$endPoint/users?page=$page&per_page=$size");
    var response = await http.get(
      url,
      headers: {
        "x-api-key": "reqres_784015e220ff422e8e50a6e7b7bc4107",
        "Accept": "application/json",
        "Content-Type": "application/json",
      },
    );

    final statusCode = response.statusCode;

    if (statusCode == 200) {
      final ListUserModel listUserModel = ListUserModel.fromJson(
        json.decode(response.body),
      );
      return listUserModel;
    } else {
      throw Exception("Get Users Error");
    }
  }
}
