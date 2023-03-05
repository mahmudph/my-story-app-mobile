/*
 * Created by mahmud on Sun Mar 05 2023
 * Email mahmud120398@gmail.com
 * Copyright (c) 2023 mahmud
 * Description
 */

import 'dart:developer' as dev;
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_story_app/utils/secure_storage.dart';

part 'splashscreen_state.dart';

class SplashscreenCubit extends Cubit<SplashscreenState> {
  final SecureStorage secureStorage;
  SplashscreenCubit({
    required this.secureStorage,
  }) : super(SplashscreenInitial());

  Future<void> checkUserIsAlreadyLogin() async {
    try {
      final result = await secureStorage.getUserToken();

      emit(
        SplashscreenAuthState(
          isAlreadyLoginUser: result != null && result.isNotEmpty,
        ),
      );
    } catch (e) {
      dev.log(e.toString());
    }
  }
}
