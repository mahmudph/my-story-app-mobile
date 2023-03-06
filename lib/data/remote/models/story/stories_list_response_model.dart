/*
 * Created by mahmud on Sat Mar 04 2023
 * Email mahmud120398@gmail.com
 * Copyright (c) 2023 mahmud
 * Description
 */

import 'dart:convert';
import 'story_model.dart';

class StoriesListResponseModel {
  StoriesListResponseModel({
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
  final List<StoryDataModel> data;

  factory StoriesListResponseModel.fromRawJson(String str) =>
      StoriesListResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StoriesListResponseModel.fromJson(Map<String, dynamic> json) =>
      StoriesListResponseModel(
        timestamp: DateTime.parse(json["timestamp"]),
        status: json["status"],
        message: json["message"],
        error: json["error"],
        data: List<StoryDataModel>.from(
          json["data"].map(
            (x) => StoryDataModel.fromJson(x),
          ),
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
