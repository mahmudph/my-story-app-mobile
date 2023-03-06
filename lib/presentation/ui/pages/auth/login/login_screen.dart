/*
 * Created by mahmud on Sun Mar 05 2023
 * Email mahmud120398@gmail.com
 * Copyright (c) 2023 mahmud
 * Description
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_story_app/utils/injectable.dart';
import 'package:my_story_app/presentation/bloc/auth/login/login_cubit.dart';

import 'login_content.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider<LoginCubit>(
          create: (_) => Injectable.getIt<LoginCubit>(),
          child: const Padding(
            padding: EdgeInsets.all(16.0),
            child: LoginContent(),
          ),
        ),
      ),
    );
  }
}
