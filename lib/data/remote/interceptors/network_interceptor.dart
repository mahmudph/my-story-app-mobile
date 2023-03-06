/*
 * Created by mahmud on Sat Mar 04 2023
 * Email mahmud120398@gmail.com
 * Copyright (c) 2023 mahmud
 * Description
 */
import 'dart:developer' as dev;
import 'package:dio/dio.dart';
import 'package:my_story_app/common/exceptions.dart';
import 'package:my_story_app/utils/secure_storage.dart';

class NetworkInterceptor implements InterceptorsWrapper {
  final SecureStorage storage;

  const NetworkInterceptor({required this.storage});

  Map<String, List<String>>? getErrorFormFiled(DioError err) {
    if (err.type == DioErrorType.badResponse) {
      /**
         * when type erorr type is caused by status code
         * then we need to get message or erorr property
        */
      final errorBody = Map<String, dynamic>.from(err.response!.data);

      final errorValue = errorBody['error'];

      if (errorBody.containsKey('error') && errorValue != null) {
        /**
           * check type of the erorr key if it a list with object then
           * foreach and get the first message
           */
        Map<String, List<String>> resultTemp = {};
        final result = Map<String, List<dynamic>>.from(errorValue);

        for (var errorKey in result.keys) {
          resultTemp[errorKey] = [];
          for (var errVal in result[errorKey]!) {
            resultTemp[errorKey]?.add(errVal);
          }
        }

        return resultTemp;
      }
    }

    return null;
  }

  String getErorrMessage(DioError err) {
    String message;

    switch (err.type) {
      case DioErrorType.connectionError:
      case DioErrorType.connectionTimeout:
      case DioErrorType.receiveTimeout:
      case DioErrorType.sendTimeout:
        message = "No internet connection, please try again";
        break;
      case DioErrorType.badResponse:
        final errorBody = Map<String, dynamic>.from(err.response!.data);
        final messageValue = errorBody['message'];

        if (errorBody.containsKey('message') && messageValue != null) {
          message = messageValue;
        } else {
          message = "Invalid form data, pelase check your form field";
        }
        break;
      default:
        message = "Failed to process request please try again";
        dev.log("erorr :${err.stackTrace}");
    }
    return message;
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    final errMessage = getErorrMessage(err);
    final errorFormField = getErrorFormFiled(err);

    throw ServerException(
      msg: errMessage,
      request: err.requestOptions,
      errorField: errorFormField,
    );
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
