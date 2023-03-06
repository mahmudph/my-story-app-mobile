/*
 * Created by mahmud on Sat Mar 04 2023
 * Email mahmud120398@gmail.com
 * Copyright (c) 2023 mahmud
 * Description
 */

import 'package:dartz/dartz.dart';
import 'package:my_story_app/common/failure.dart';
import 'package:my_story_app/domain/entities/user_entity.dart';

abstract class AuthRepositoryContract {
  Future<Either<Failure, String>> login(Map<String, dynamic> data);
  Future<Either<Failure, UserEntity>> register(Map<String, dynamic> data);
  Future<Either<Failure, UserEntity>> progile();
}
