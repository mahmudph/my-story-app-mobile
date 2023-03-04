/*
 * Created by mahmud on Sat Mar 04 2023
 * Email mahmud120398@gmail.com
 * Copyright (c) 2023 mahmud
 * Description
 */

import 'package:dartz/dartz.dart';
import 'package:my_story_app/common/failure.dart';
import 'package:my_story_app/domain/repository/auth_repository_contract.dart';
import 'package:my_story_app/utils/secure_storage.dart';

class LoginUseCase {
  final SecureStorage storage;
  final AuthRepositoryContract repository;

  const LoginUseCase({
    required this.repository,
    required this.storage,
  });

  Future<Either<Failure, String>> invoke(Map<String, dynamic> data) async {
    final result = await repository.login(data);

    if (result.isRight()) {
      final token = result.getOrElse(() => '');
      await storage.setUserToken(token);
    }

    return result;
  }
}
