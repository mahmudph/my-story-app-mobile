/*
 * Created by mahmud on Sat Mar 04 2023
 * Email mahmud120398@gmail.com
 * Copyright (c) 2023 mahmud
 * Description
 */

import 'package:my_story_app/common/exceptions.dart';
import 'package:my_story_app/domain/repository/story_repository_contract.dart';
import 'package:my_story_app/domain/entities/story_entity.dart';
import 'package:my_story_app/common/failure.dart';
import 'package:dartz/dartz.dart';

import 'remote/remote_data_source.dart';

class StoryRepositoryImpl implements StoryRepositoryContract {
  final RemoteDataSourceContract remoteDataSource;

  const StoryRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, StoryEntity>> createNewStory(
    Map<String, dynamic> data,
  ) async {
    try {
      final result = await remoteDataSource.createStory(data);
      return Right(result.data.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, String>> deleteStoryById(int id) async {
    try {
      final result = await remoteDataSource.deleteStoryById(id);
      return Right(result.message);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<StoryEntity>>> getStoriList() async {
    try {
      final result = await remoteDataSource.getListStories();
      return Right(result.data.map((e) => e.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, StoryEntity>> getStoryById(int id) async {
    try {
      final result = await remoteDataSource.getStoryById(id);
      return Right(result.data.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}
