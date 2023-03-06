/*
 * Created by mahmud on Sat Mar 04 2023
 * Email mahmud120398@gmail.com
 * Copyright (c) 2023 mahmud
 * Description
 */

import 'dart:convert';
import 'story_model.dart';

class GetStoryByIdResponseModel {
  GetStoryByIdResponseModel({
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
  final StoryDataModel data;

  factory GetStoryByIdResponseModel.fromRawJson(String str) =>
      GetStoryByIdResponseModel.fromJson(
        json.decode(str),
      );

  String toRawJson() => json.encode(toJson());

  factory GetStoryByIdResponseModel.fromJson(Map<String, dynamic> json) =>
      GetStoryByIdResponseModel(
        timestamp: DateTime.parse(json["timestamp"]),
        status: json["status"],
        message: json["message"],
        error: json["error"],
        data: StoryDataModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "timestamp": timestamp.toIso8601String(),
        "status": status,
        "message": message,
        "error": error,
        "data": data.toJson(),
      };
}
