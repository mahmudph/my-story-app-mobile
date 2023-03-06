/*
 * Created by mahmud on Sat Mar 04 2023
 * Email mahmud120398@gmail.com
 * Copyright (c) 2023 mahmud
 * Description
 */

import 'dart:convert';
import 'login_data_model.dart';

class LoginResponseModel {
  LoginResponseModel({
    required this.timestamp,
    required this.status,
    required this.message,
    required this.data,
    this.error,
  });

  final DateTime timestamp;
  final String status;
  final String message;
  final dynamic error;
  final LoginDataModel data;

  factory LoginResponseModel.fromRawJson(String str) =>
      LoginResponseModel.fromJson(
        json.decode(str),
      );

  String toRawJson() => json.encode(toJson());

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginResponseModel(
        timestamp: DateTime.parse(json["timestamp"]),
        status: json["status"],
        message: json["message"],
        error: json["error"],
        data: LoginDataModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "timestamp": timestamp.toIso8601String(),
        "status": status,
        "message": message,
        "error": error,
        "data": data.toJson(),
      };
}
