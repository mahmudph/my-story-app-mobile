/*
 * Created by mahmud on Sat Mar 04 2023
 * Email mahmud120398@gmail.com
 * Copyright (c) 2023 mahmud
 * Description
 */

import 'package:dartz/dartz.dart';
import 'package:my_story_app/common/failure.dart';
import 'package:my_story_app/domain/repository/story_repository_contract.dart';

class DeleteStoryUseCase {
  final StoryRepositoryContract repository;

  DeleteStoryUseCase({required this.repository});

  Future<Either<Failure, String>> invoke(int id) async {
    return await repository.deleteStoryById(id);
  }
}
