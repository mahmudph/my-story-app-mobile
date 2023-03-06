/*
 * Created by mahmud on Sat Mar 04 2023
 * Email mahmud120398@gmail.com
 * Copyright (c) 2023 mahmud
 * Description
 */

class CategoryEntity {
  CategoryEntity({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
