/*
 * Created by mahmud on Mon Mar 06 2023
 * Email mahmud120398@gmail.com
 * Copyright (c) 2023 mahmud
 * Description
 */
import 'dart:developer' as dev;
import 'package:dartz/dartz.dart';
import 'package:my_story_app/common/failure.dart';
import 'package:my_story_app/utils/secure_storage.dart';

class LogoutUseCase {
  final SecureStorage secureStorage;
  LogoutUseCase({required this.secureStorage});

  Future<Either<Failure, String>> invoke() async {
    try {
      await secureStorage.setUserToken('');
      return const Right('logout success');
    } catch (e) {
      dev.log(e.toString());
      return const Left(StorageFailure(message: 'failed to logout'));
    }
  }
}
