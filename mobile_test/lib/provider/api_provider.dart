import 'package:flutter/material.dart';
import 'package:mobile_test/model/api_state.dart';
import 'package:mobile_test/model/user_model.dart';
import 'package:mobile_test/service/api_service.dart';

class ApiProvider extends ChangeNotifier {
  final ApiService apiService;

  ApiProvider(this.apiService);

  ApiState userState = ApiState.initial;
  String quotesMessage = "";

  bool quotesError = false;

  List<UserModel> qoutes = [];

  int? pageItems = 1;
  int sizeItems = 10;

  Future<void> getUsers() async {
    try {
      if (pageItems == 1) {
        userState = ApiState.loading;
        notifyListeners();
      }

      final result = await apiService.getUsers(pageItems!, sizeItems);
      qoutes.addAll(result.data);
      quotesMessage = "Success";
      quotesError = false;
      userState = ApiState.loaded;
      if (result.data.length < sizeItems) {
        pageItems = null;
      } else {
        pageItems = pageItems! + 1;
      }

      notifyListeners();
    } catch (e) {
      userState = ApiState.error;
      quotesError = true;
      quotesMessage = "Get user failed";
      notifyListeners();
    }
  }
}
