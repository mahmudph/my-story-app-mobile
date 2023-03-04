/*
 * Created by mahmud on Sat Mar 04 2023
 * Email mahmud120398@gmail.com
 * Copyright (c) 2023 mahmud
 * Description
 */

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class HttpClientConfigurations {
  ///
  /// this base url of the application will use
  static get baseUrl =>
      dotenv.env['BASE_URL'] ?? 'https://pelatihan.semanja.xyz';

  /// connection timeout duration in seconds
  static get connectionTimeout => 20;
  static get receivedTimeOut => 20;
  static get sendTimeout => 20;

  /// get http options
  static BaseOptions getOptions() => BaseOptions(
        baseUrl: baseUrl,
        sendTimeout: sendTimeout,
        receiveTimeout: receivedTimeOut,
        connectTimeout: connectionTimeout,
        contentType: 'application/json',
        headers: {
          'x-api-key': dotenv.env["API_KEY"] ?? '',
          'accept': 'application/json',
          'content-type': 'application/json',
        },
      );
}
