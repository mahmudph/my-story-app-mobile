/*
 * Created by mahmud on Sat Mar 04 2023
 * Email mahmud120398@gmail.com
 * Copyright (c) 2023 mahmud
 * Description
 */

import 'package:dio/dio.dart';

class ServerException extends DioError {
  final String msg;
  final Map<String, List<String>>? errorField;
  final RequestOptions request;

  ServerException({
    this.errorField,
    required this.msg,
    required this.request,
  }) : super(message: msg, requestOptions: request);
}

class DatabaseException implements Exception {
  final String message;
  DatabaseException({required this.message});
}
