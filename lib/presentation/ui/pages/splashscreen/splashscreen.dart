/*
 * Created by mahmud on Sun Mar 05 2023
 * Email mahmud120398@gmail.com
 * Copyright (c) 2023 mahmud
 * Description
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_story_app/presentation/bloc/bloc.dart';
import 'package:my_story_app/utils/injectable.dart';

import 'splashscreen_content.dart';

class Splashscreen extends StatelessWidget {
  const Splashscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider<SplashscreenCubit>(
          create: (context) => SplashscreenCubit(
            secureStorage: Injectable.getIt(),
          ),
          child: const SplashScreenContent(),
        ),
      ),
    );
  }
}
