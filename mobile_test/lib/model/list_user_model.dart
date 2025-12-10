import 'package:mobile_test/model/user_model.dart';

class ListUserModel {
  List<UserModel> data;

  ListUserModel({required this.data});

  factory ListUserModel.fromJson(Map<String, dynamic> json) => ListUserModel(
    data: List<UserModel>.from(json["data"].map((x) => UserModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}
