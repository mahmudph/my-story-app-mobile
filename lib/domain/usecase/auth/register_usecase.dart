/*
 * Created by mahmud on Sat Mar 04 2023
 * Email mahmud120398@gmail.com
 * Copyright (c) 2023 mahmud
 * Description
 */

import 'package:dartz/dartz.dart';
import 'package:my_story_app/common/failure.dart';
import 'package:my_story_app/domain/entities/user_entity.dart';
import 'package:my_story_app/domain/repository/auth_repository_contract.dart';

class RegisterUseCase {
  final AuthRepositoryContract repository;

  const RegisterUseCase({required this.repository});

  Future<Either<Failure, UserEntity>> invoke(Map<String, dynamic> data) async {
    final result = await repository.register(data);
    return result;
  }
}
