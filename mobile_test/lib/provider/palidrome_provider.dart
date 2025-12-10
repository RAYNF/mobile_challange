import 'package:flutter/material.dart';
import 'package:mobile_test/utils/palidrome_checker.dart';

class PalidromeProvider extends ChangeNotifier {
  String? resultMessage;
  String? nameFirstScreen;
  String? selectedUserName;

  void check(String text) {
    final isPali = checkPalidrom(text);

    resultMessage = isPali ? "isPalidrome" : "Not palidrome";
    notifyListeners();
  }

  void setNameFirstScreen(String name) {
    nameFirstScreen = name;
    notifyListeners();
  }

  void setSelectedUser(String name) {
    selectedUserName = name;
    notifyListeners();
  }
}
