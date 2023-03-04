/*
 * Created by mahmud on Sat Mar 04 2023
 * Email mahmud120398@gmail.com
 * Copyright (c) 2023 mahmud
 * Description
 */

import 'package:dartz/dartz.dart';
import 'package:my_story_app/common/failure.dart';
import 'package:my_story_app/domain/entities/story_entity.dart';

abstract class StoryRepositoryContract {
  Future<Either<Failure, List<StoryEntity>>> getStoriList();
  Future<Either<Failure, StoryEntity>> getStoryById(int id);
  Future<Either<Failure, String>> deleteStoryById(int id);
  Future<Either<Failure, StoryEntity>> createNewStory(
    Map<String, dynamic> data,
  );
}
