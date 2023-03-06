/*
 * Created by mahmud on Sun Mar 05 2023
 * Email mahmud120398@gmail.com
 * Copyright (c) 2023 mahmud
 * Description
 */

import 'package:dartz/dartz.dart';
import 'package:my_story_app/common/failure.dart';
import 'package:my_story_app/domain/entities/category_entity.dart';
import 'package:my_story_app/domain/repository/story_repository_contract.dart';

class GetCategoryUsecase {
  final StoryRepositoryContract repository;

  const GetCategoryUsecase({required this.repository});

  Future<Either<Failure, List<CategoryEntity>>> invoke() async {
    return repository.getCategories();
  }
}
