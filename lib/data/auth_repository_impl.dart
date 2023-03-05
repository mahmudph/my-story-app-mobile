/*
 * Created by mahmud on Sat Mar 04 2023
 * Email mahmud120398@gmail.com
 * Copyright (c) 2023 mahmud
 * Description
 */

import 'package:dartz/dartz.dart';
import 'package:my_story_app/common/exceptions.dart';
import 'package:my_story_app/common/failure.dart';
import 'package:my_story_app/domain/entities/user_entity.dart';
import 'package:my_story_app/domain/repository/auth_repository_contract.dart';

import 'remote/remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepositoryContract {
  final RemoteDataSourceContract remoteDataSource;

  const AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, String>> login(Map<String, dynamic> data) async {
    try {
      final result = await remoteDataSource.login(data);
      return Right(result.data.token);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.msg, errorFields: e.errorField));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> progile() async {
    try {
      final result = await remoteDataSource.getProfile();
      return Right(result.data.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.msg));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> register(
    Map<String, dynamic> data,
  ) async {
    try {
      final result = await remoteDataSource.register(data);
      return Right(result.data.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.msg, errorFields: e.errorField));
    }
  }
}
