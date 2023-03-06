/*
 * Created by mahmud on Sun Mar 05 2023
 * Email mahmud120398@gmail.com
 * Copyright (c) 2023 mahmud
 * Description
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_story_app/presentation/bloc/bloc.dart';
import 'package:my_story_app/presentation/routes/routes.dart';

class SplashScreenContent extends StatefulWidget {
  const SplashScreenContent({super.key});

  @override
  State<SplashScreenContent> createState() => _SplashScreenContentState();
}

class _SplashScreenContentState extends State<SplashScreenContent> {
  final duration = const Duration(seconds: 2);

  @override
  void initState() {
    super.initState();
    handleNavigateToHomeScreen();
  }

  void handleNavigateToHomeScreen() {
    Future.delayed(duration).then((_) {
      final bloc = BlocProvider.of<SplashscreenCubit>(context, listen: false);
      bloc.checkUserIsAlreadyLogin();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocListener<SplashscreenCubit, SplashscreenState>(
      listener: (context, state) {
        if (state is SplashscreenAuthState) {
          // deffine destination
          Navigator.pushNamedAndRemoveUntil(
            context,
            state.isAlreadyLoginUser ? RouteName.home : RouteName.login,
            (route) => false,
          );
        }
      },
      child: Center(
        child: SizedBox(
          height: size.width * 0.50,
          width: size.width * 0.50,
          child: Image.asset(
            'assets/images/logo.png',
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
