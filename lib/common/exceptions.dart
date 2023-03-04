/*
 * Created by mahmud on Sat Mar 04 2023
 * Email mahmud120398@gmail.com
 * Copyright (c) 2023 mahmud
 * Description
 */

class ServerInterceptorException implements Exception {
  final String message;
  const ServerInterceptorException({required this.message});
}

class ServerException implements Exception {
  final String message;
  ServerException({required this.message});
}

class DatabaseException implements Exception {
  final String message;
  DatabaseException({required this.message});
}
