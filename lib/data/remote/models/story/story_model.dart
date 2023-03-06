/*
 * Created by mahmud on Sat Mar 04 2023
 * Email mahmud120398@gmail.com
 * Copyright (c) 2023 mahmud
 * Description
 */

import 'dart:convert';
import 'package:my_story_app/domain/entities/story_entity.dart';

import '../auth/user_data_model.dart';
import 'category_model.dart';

class StoryDataModel {
  StoryDataModel({
    required this.id,
    required this.userId,
    required this.categoryId,
    required this.title,
    required this.description,
    required this.photo,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
    required this.category,
  });

  final int id;
  final int userId;
  final int categoryId;
  final String title;
  final String description;
  final String photo;
  final DateTime createdAt;
  final DateTime updatedAt;
  final UserDataModel user;
  final CategoryModel category;

  factory StoryDataModel.fromRawJson(String str) => StoryDataModel.fromJson(
        json.decode(str),
      );

  factory StoryDataModel.fromJson(Map<String, dynamic> json) => StoryDataModel(
        id: json["id"],
        userId: json["user_id"],
        categoryId: json["category_id"].runtimeType == String
            ? int.parse(json["category_id"] as String)
            : json["category_id"],
        title: json["title"],
        description: json["description"],
        photo: json["photo"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        user: UserDataModel.fromJson(json["user"]),
        category: CategoryModel.fromJson(json["category"]),
      );

  StoryEntity toEntity() => StoryEntity(
        id: id,
        title: title,
        description: description,
        photo: photo,
        createdAt: createdAt,
        user: user.toEntity(),
        category: category.toEntity(),
      );

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "category_id": categoryId,
        "title": title,
        "description": description,
        "photo": photo,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "user": user.toJson(),
        "category": category.toJson(),
      };
}
