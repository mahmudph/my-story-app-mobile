/*
 * Created by mahmud on Sun Mar 05 2023
 * Email mahmud120398@gmail.com
 * Copyright (c) 2023 mahmud
 * Description
 */

import 'dart:convert';
import 'category_model.dart';

class CategoryResponse {
  CategoryResponse({
    required this.timestamp,
    required this.status,
    this.message,
    this.error,
    required this.data,
  });

  final DateTime timestamp;
  final String status;
  final dynamic message;
  final dynamic error;
  final List<CategoryModel> data;

  factory CategoryResponse.fromRawJson(String str) =>
      CategoryResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CategoryResponse.fromJson(Map<String, dynamic> json) =>
      CategoryResponse(
        timestamp: DateTime.parse(json["timestamp"]),
        status: json["status"],
        message: json["message"],
        error: json["error"],
        data: List<CategoryModel>.from(
          json["data"].map((x) => CategoryModel.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
        "timestamp": timestamp.toIso8601String(),
        "status": status,
        "message": message,
        "error": error,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}
