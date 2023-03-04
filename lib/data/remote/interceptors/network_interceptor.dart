/*
 * Created by mahmud on Sat Mar 04 2023
 * Email mahmud120398@gmail.com
 * Copyright (c) 2023 mahmud
 * Description
 */

import 'package:dio/dio.dart';
import 'package:my_story_app/common/exceptions.dart';
import 'package:my_story_app/utils/secure_storage.dart';

class NetworkInterceptor implements InterceptorsWrapper {
  final SecureStorage storage;

  const NetworkInterceptor({required this.storage});

  String getErorrMessage(DioError err) {
    String message = "failed to process request please try again";

    switch (err.type) {
      case DioErrorType.connectionError:
      case DioErrorType.connectionTimeout:
      case DioErrorType.receiveTimeout:
      case DioErrorType.sendTimeout:
        message = "No internet connection, please try again";
        break;
      case DioErrorType.badResponse:
        /**
         * when type erorr type is caused by status code
         * then we need to get message or erorr property
         */
        final errorBody = Map<String, dynamic>.from(err.response!.data);

        final errorValue = errorBody['error'];
        final messageValue = errorBody['message'];

        if (errorBody.containsKey('message') && messageValue != null) {
          /**
           * when there is property message and it not null then use this
           * message
           */
          message = messageValue;
        } else if (errorBody.containsKey('error') && errorValue != null) {
          /**
           * check type of the erorr key if it a list with object then
           * foreach and get the first message
           */
          final mapErrorValue = Map<String, List<String>>.from(errorValue);

          for (var error in mapErrorValue.keys) {
            message += mapErrorValue[error]!.join(",");
          }
        }

        break;

      default:
    }
    return message;
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    final errMessage = getErorrMessage(err);
    throw ServerException(message: errMessage);
  }

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final userToken = await storage.getUserToken();
    options.headers['Authorization'] = 'Bearer $userToken';
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    return handler.next(response);
  }
}
