/*
 * Created by mahmud on Sat Mar 04 2023
 * Email mahmud120398@gmail.com
 * Copyright (c) 2023 mahmud
 * Description
 */

import 'dart:convert';

class DeleteStoryByIdResponseModel {
  DeleteStoryByIdResponseModel({
    required this.timestamp,
    required this.status,
    required this.message,
    this.error,
    this.data,
  });

  final DateTime timestamp;
  final String status;
  final String message;
  final dynamic error;
  final dynamic data;

  factory DeleteStoryByIdResponseModel.fromRawJson(String str) =>
      DeleteStoryByIdResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DeleteStoryByIdResponseModel.fromJson(Map<String, dynamic> json) =>
      DeleteStoryByIdResponseModel(
        timestamp: DateTime.parse(json["timestamp"]),
        status: json["status"],
        message: json["message"],
        error: json["error"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "timestamp": timestamp.toIso8601String(),
        "status": status,
        "message": message,
        "error": error,
        "data": data,
      };
}
