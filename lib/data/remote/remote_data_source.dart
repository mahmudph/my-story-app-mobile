/*
 * Created by mahmud on Sat Mar 04 2023
 * Email mahmud120398@gmail.com
 * Copyright (c) 2023 mahmud
 * Description
 */

import 'package:dio/dio.dart';

import 'models/auth/user_response_model.dart';
import 'models/auth/login_response_model.dart';
import 'models/auth/register_response_model.dart';
import 'models/story/category_response_model.dart';
import 'models/story/create_story_response_model.dart';
import 'models/story/delete_story_by_id_response_model.dart';
import 'models/story/get_story_by_id_response_model.dart';
import 'models/story/stories_list_response_model.dart';

abstract class RemoteDataSourceContract {
  Future<StoriesListResponseModel> getListStories();
  Future<GetStoryByIdResponseModel> getStoryById(int id);
  Future<DeleteStoryByIdResponseModel> deleteStoryById(int id);
  Future<CreateStoryResponseModel> createStory(Map<String, dynamic> data);

  Future<UserProfileResponse> getProfile();
  Future<LoginResponseModel> login(Map<String, dynamic> data);
  Future<RegisterResponseModel> register(Map<String, dynamic> data);
  Future<CategoryResponse> getCategories();
}

class RemoteDataSource implements RemoteDataSourceContract {
  final Dio client;

  const RemoteDataSource({required this.client});

  @override
  Future<StoriesListResponseModel> getListStories() async {
    final result = await client.get('/api/stories');
    return StoriesListResponseModel.fromJson(result.data);
  }

  @override
  Future<UserProfileResponse> getProfile() async {
    final result = await client.get('/api/user');
    return UserProfileResponse.fromJson(result.data);
  }

  @override
  Future<GetStoryByIdResponseModel> getStoryById(int id) async {
    final result = await client.get('/api/stories/$id');
    return GetStoryByIdResponseModel.fromJson(result.data);
  }

  @override
  Future<LoginResponseModel> login(Map<String, dynamic> data) async {
    final result = await client.post('/api/auth/login', data: data);
    return LoginResponseModel.fromJson(result.data);
  }

  @override
  Future<RegisterResponseModel> register(Map<String, dynamic> data) async {
    final result = await client.post('/api/auth/register', data: data);
    return RegisterResponseModel.fromJson(result.data);
  }

  @override
  Future<CreateStoryResponseModel> createStory(
    Map<String, dynamic> data,
  ) async {
    final result = await client.post('/api/stories', data: data);
    return CreateStoryResponseModel.fromJson(result.data);
  }

  @override
  Future<DeleteStoryByIdResponseModel> deleteStoryById(int id) async {
    final result = await client.delete('/api/stories/$id');
    return DeleteStoryByIdResponseModel.fromJson(result.data);
  }

  @override
  Future<CategoryResponse> getCategories() async {
    final result = await client.get('/api/categories');
    return CategoryResponse.fromJson(result.data);
  }
}
