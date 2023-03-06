/*
 * Created by mahmud on Sat Mar 04 2023
 * Email mahmud120398@gmail.com
 * Copyright (c) 2023 mahmud
 * Description
 */

import 'dart:convert';

class LoginDataModel {
  LoginDataModel({
    required this.token,
  });

  final String token;

  factory LoginDataModel.fromRawJson(String str) =>
      LoginDataModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LoginDataModel.fromJson(Map<String, dynamic> json) => LoginDataModel(
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
      };
}
