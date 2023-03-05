/*
 * Created by mahmud on Sat Mar 04 2023
 * Email mahmud120398@gmail.com
 * Copyright (c) 2023 mahmud
 * Description
 */

import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure({required this.message});

  @override
  List<Object> get props => [message];
}

class ServerFailure extends Failure {
  final Map<String, List<String>>? errorFields;

  const ServerFailure({
    required String message,
    this.errorFields,
  }) : super(message: message);
}

class DatabaseFailure extends Failure {
  const DatabaseFailure({required String message}) : super(message: message);
}
