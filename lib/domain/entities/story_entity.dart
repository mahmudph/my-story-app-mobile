/*
 * Created by mahmud on Sat Mar 04 2023
 * Email mahmud120398@gmail.com
 * Copyright (c) 2023 mahmud
 * Description
 */

import 'category_entity.dart';
import 'user_entity.dart';

class StoryEntity {
  StoryEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.photo,
    required this.user,
    required this.category,
  });

  final int id;
  final String title;
  final String description;
  final String photo;
  final UserEntity user;
  final CategoryEntity category;

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "photo": photo,
        "user": user.toJson(),
        "category": category.toJson(),
      };
}
