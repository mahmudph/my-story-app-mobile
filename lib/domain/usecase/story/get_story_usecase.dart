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

class GetStoryUseCase {
  final StoryRepositoryContract repository;

  const GetStoryUseCase({required this.repository});

  Future<Either<Failure, StoryEntity>> invoke(int id) async {
    return await repository.getStoryById(id);
  }
}
