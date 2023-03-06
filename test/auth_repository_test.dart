/*
 * Created by mahmud on Tue Mar 07 2023
 * Email mahmud120398@gmail.com
 * Copyright (c) 2023 mahmud
 * Description
 */

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_story_app/common/exceptions.dart';
import 'package:my_story_app/common/failure.dart';
import 'package:my_story_app/data/auth_repository_impl.dart';
import 'package:my_story_app/data/remote/models/auth/login_response_model.dart';
import 'package:my_story_app/data/remote/models/auth/register_response_model.dart';
import 'package:my_story_app/data/remote/models/auth/user_response_model.dart';
import 'package:my_story_app/data/remote/remote_data_source.dart';
import 'package:my_story_app/domain/repository/auth_repository_contract.dart';

class MockRemoteDataSource extends Mock implements RemoteDataSourceContract {}

void main() {
  late MockRemoteDataSource mockRemoteDataSource;
  late AuthRepositoryContract authRepository;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    authRepository = AuthRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
    );
  });

  group('test login', () {
    test('should success', () async {
      // stub
      final payload = {'email': 'test@gmail.com', 'password': 'password'};
      final expectedResult = LoginResponseModel.fromJson(
        {
          "timestamp": "2023-03-06T22:53:36.881402Z",
          "status": "SUCCESS",
          "message": "Login successfull",
          "error": null,
          "data": {"token": "8|JqVxyUb9lTm0GqqDtv69T3xKyw01PGeHEPT2bs44"}
        },
      );

      when(() => mockRemoteDataSource.login(payload)).thenAnswer(
        (_) async => expectedResult,
      );

      // act
      final result = await authRepository.login(payload);

      // assert have valid token
      expect(result, Right(expectedResult.data.token));
    });

    test('should failure with erorr field', () async {
      // stub
      final payload = {'email': 'test', 'password': 'password'};
      final expectedResult = ServerException(
        msg: 'Invalid form data, pelase check your form field',
        errorField: {
          'email': [
            "The email field must be a valid email address.",
          ]
        },
        request: RequestOptions(baseUrl: 'baseurl'),
      );

      when(() => mockRemoteDataSource.login(payload)).thenAnswer(
        (_) async => throw expectedResult,
      );

      // act
      final result = await authRepository.login(payload);

      // assert
      expect(
        result,
        Left(
          ServerFailure(
            message: expectedResult.msg,
            errorFields: expectedResult.errorField,
          ),
        ),
      );
    });

    test('should failure when no internet connection', () async {
      // stub
      final payload = {'email': 'test', 'password': 'password'};
      final expectedResult = ServerException(
        msg: "No internet connection, please try again",
        request: RequestOptions(),
      );

      when(() => mockRemoteDataSource.login(payload)).thenAnswer(
        (_) async => throw expectedResult,
      );

      // act
      final result = await authRepository.login(payload);

      // assert
      expect(result, Left(ServerFailure(message: expectedResult.msg)));
    });
  });

  group('test register', () {
    test('should success', () async {
      // stub
      final payload = {
        'name': 'andika',
        'email': 'andika@gmail.com',
        'password': '12345678',
        'password_confirmation': '12345678',
      };

      final expectedResult = RegisterResponseModel.fromJson({
        "timestamp": "2023-02-26T05:15:40.798733Z",
        "status": "SUCCESS",
        "message": "Register successfull",
        "error": null,
        "data": {
          "name": "andika",
          "email": "andika@gmail.com",
          "updated_at": "2023-02-26T05:15:40.000000Z",
          "created_at": "2023-02-26T05:15:40.000000Z",
          "id": 1
        }
      });

      when(() => mockRemoteDataSource.register(payload)).thenAnswer(
        (_) async => expectedResult,
      );

      // act
      final result = await authRepository.register(payload);

      // assert
      expect(result.isRight(), isTrue);
    });
    test('should failure when password confirmation not same', () async {
      // assert
      final payload = {
        'name': 'andika',
        'email': 'andika@gmail.com',
        'password': '12345678',
        'password_confirmation': '12345678',
      };

      final expectedResult = ServerException(
        msg: "Invalid form data, pelase check your form field",
        request: RequestOptions(baseUrl: '/'),
        errorField: {
          "password_confirmation": [
            "The password confirmation field must match password."
          ]
        },
      );

      when(() => mockRemoteDataSource.register(payload)).thenAnswer(
        (_) async => throw expectedResult,
      );

      // act
      final result = await authRepository.register(payload);

      // assert
      expect(
        result,
        const Left(
          ServerFailure(
            message: "Invalid form data, pelase check your form field",
            errorFields: {
              'password_confirmation': [
                "The password confirmation field must match password."
              ]
            },
          ),
        ),
      );
    });

    test('should failure when no internet connection', () async {
      // stub
      final payload = {
        'name': 'andika',
        'email': 'andika@gmail.com',
        'password': '12345678',
        'password_confirmation': '12345678',
      };

      final expectedResult = ServerException(
        msg: "No internet connection, please try again",
        request: RequestOptions(),
      );

      when(() => mockRemoteDataSource.register(payload)).thenAnswer(
        (_) async => throw expectedResult,
      );

      // act
      final result = await authRepository.register(payload);

      // assert
      expect(result, Left(ServerFailure(message: expectedResult.msg)));
    });
  });

  group('test user', () {
    test('should success and get data user', () async {
      // stub
      final expectedResult = UserProfileResponse.fromJson({
        "timestamp": "2023-03-06T23:23:22.296037Z",
        "status": "SUCCESS",
        "message": null,
        "error": null,
        "data": {
          "id": 8,
          "name": "Shyann",
          "email": "Isabell4@hotmail.com",
          "email_verified_at": null,
          "created_at": "2023-03-05T12:16:59.000000Z",
          "updated_at": "2023-03-05T12:16:59.000000Z"
        }
      });

      when(() => mockRemoteDataSource.getProfile()).thenAnswer(
        (_) async => expectedResult,
      );
      // act
      final result = await authRepository.progile();
      // assert
      expect(result.isRight(), isTrue);
    });

    test('should failure when no internet connection', () async {
      // stub
      final expectedResult = ServerException(
        msg: "No internet connection, please try again",
        request: RequestOptions(),
      );

      when(() => mockRemoteDataSource.getProfile()).thenAnswer(
        (_) async => throw expectedResult,
      );

      // act
      final result = await authRepository.progile();

      // assert
      expect(result, Left(ServerFailure(message: expectedResult.msg)));
    });
  });
}
