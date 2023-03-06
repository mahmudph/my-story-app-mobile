/*
 * Created by mahmud on Sat Mar 04 2023
 * Email mahmud120398@gmail.com
 * Copyright (c) 2023 mahmud
 * Description
 */

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_story_app/domain/usecase/auth/logout_usecase.dart';
import 'package:my_story_app/utils/secure_storage.dart';
import 'package:my_story_app/domain/usecase/usecase.dart';
import 'package:my_story_app/presentation/bloc/bloc.dart';
import 'package:my_story_app/data/auth_repository_impl.dart';
import 'package:my_story_app/data/story_repository_impl.dart';
import 'package:my_story_app/data/remote/remote_data_source.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:my_story_app/data/remote/interceptors/network_interceptor.dart';
import 'package:my_story_app/domain/repository/auth_repository_contract.dart';
import 'package:my_story_app/domain/repository/story_repository_contract.dart';
import 'package:my_story_app/domain/usecase/story/get_category_usecase.dart';

import 'http_client_options.dart';

class Injectable {
  Injectable._privateConstructor();

  static final Injectable instance = Injectable._privateConstructor();

  static GetIt get getIt => GetIt.instance;

  void register() async {
    registerScureStorage();
    registerHttpClient();
    registerDataSources();
    registerUtility();

    registerRepositories();
    registerAuthUseCase();
    registerStoryUseCase();

    registerBloc();
  }

  void registerUtility() {
    getIt.registerLazySingleton<ImagePicker>(() => ImagePicker());
  }

  void registerScureStorage() {
    getIt.registerLazySingleton<FlutterSecureStorage>(
      () => const FlutterSecureStorage(),
    );
    getIt.registerLazySingleton<SecureStorage>(
      () => SecureStorage(storage: getIt<FlutterSecureStorage>()),
    );
  }

  /// register dio client
  void registerHttpClient() {
    getIt.registerLazySingleton<Dio>(() {
      /**
       * create http dio client options
       */
      final httpOptions = HttpClientConfigurations.getOptions();

      /**
       * create dio http client and custom interceptor
       */
      final dio = Dio(httpOptions);
      dio.interceptors.add(NetworkInterceptor(storage: getIt()));
      return dio;
    });
  }

  /// register data sources
  void registerDataSources() {
    getIt.registerLazySingleton<RemoteDataSourceContract>(
      () => RemoteDataSource(client: getIt()),
    );
  }

  /// register repository
  void registerRepositories() {
    getIt.registerLazySingleton<AuthRepositoryContract>(
      () => AuthRepositoryImpl(remoteDataSource: getIt()),
    );

    getIt.registerLazySingleton<StoryRepositoryContract>(
      () => StoryRepositoryImpl(remoteDataSource: getIt()),
    );
  }

  /// register usecase of auth
  void registerAuthUseCase() {
    getIt.registerLazySingleton(
      () => LogoutUseCase(secureStorage: getIt()),
    );
    getIt.registerLazySingleton<LoginUseCase>(
      () => LoginUseCase(repository: getIt(), storage: getIt()),
    );

    getIt.registerLazySingleton<RegisterUseCase>(
      () => RegisterUseCase(repository: getIt()),
    );

    getIt.registerLazySingleton<ProfileUseCase>(
      () => ProfileUseCase(repository: getIt()),
    );
  }

  /// register usecase of story
  void registerStoryUseCase() {
    getIt.registerLazySingleton<CreateStoryUseCase>(
      () => CreateStoryUseCase(repository: getIt()),
    );

    getIt.registerLazySingleton<DeleteStoryUseCase>(
      () => DeleteStoryUseCase(repository: getIt()),
    );

    getIt.registerLazySingleton<GetStoriesUseCase>(
      () => GetStoriesUseCase(repository: getIt()),
    );

    getIt.registerLazySingleton<GetStoryUseCase>(
      () => GetStoryUseCase(repository: getIt()),
    );

    getIt.registerLazySingleton<GetCategoryUsecase>(
      () => GetCategoryUsecase(repository: getIt()),
    );
  }

  void registerBloc() {
    getIt.registerFactory<LoginCubit>(() => LoginCubit(login: getIt()));

    getIt.registerFactory<UserCubit>(
      () => UserCubit(profileUseCase: getIt(), logoutUseCase: getIt()),
    );

    getIt.registerFactory<RegisterCubit>(
      () => RegisterCubit(registerUseCase: getIt()),
    );

    getIt.registerFactory<CreateStoryCubit>(
      () => CreateStoryCubit(createStoryUseCase: getIt()),
    );

    getIt.registerFactory<ListStoryCubit>(
      () => ListStoryCubit(getStoriesUseCase: getIt()),
    );

    getIt.registerFactory<DetailStoryCubit>(
      () => DetailStoryCubit(
        getStoryUseCase: getIt(),
      ),
    );

    getIt.registerFactory<ListCategoryCubit>(
      () => ListCategoryCubit(getCategoryUsecase: getIt()),
    );
  }
}
