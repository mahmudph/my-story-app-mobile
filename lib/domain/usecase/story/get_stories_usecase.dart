/*
 * Created by mahmud on Sat Mar 04 2023
 * Email mahmud120398@gmail.com
 * Copyright (c) 2023 mahmud
 * Description
 */

import 'package:dartz/dartz.dart';
import 'package:my_story_app/common/failure.dart';
import 'package:my_story_app/domain/entities/story_entity.dart';
import 'package:my_story_app/domain/repository/story_repository_contract.dart';

class GetStoriesUseCase {
  final StoryRepositoryContract repository;

  const GetStoriesUseCase({required this.repository});

  Future<Either<Failure, List<StoryEntity>>> invoke() async {
    return await repository.getStoriList();
  }
}
