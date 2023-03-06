/*
 * Created by mahmud on Sun Mar 05 2023
 * Email mahmud120398@gmail.com
 * Copyright (c) 2023 mahmud
 * Description
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_story_app/utils/injectable.dart';
import 'package:my_story_app/presentation/bloc/auth/register/register_cubit.dart';
import 'package:my_story_app/presentation/ui/pages/auth/register/register_content.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: SafeArea(
        child: BlocProvider<RegisterCubit>(
          create: (_) => Injectable.getIt<RegisterCubit>(),
          child: Padding(
            padding: const EdgeInsets.all(16.0).copyWith(top: 0),
            child: const RegisterContent(),
          ),
        ),
      ),
    );
  }
}
