/*
 * Created by mahmud on Sun Mar 05 2023
 * Email mahmud120398@gmail.com
 * Copyright (c) 2023 mahmud
 * Description
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_story_app/presentation/bloc/bloc.dart';
import 'package:my_story_app/utils/injectable.dart';

import 'create_story_content.dart';

class CreateStoryScreen extends StatelessWidget {
  const CreateStoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Create Story",
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: BlocProvider<CreateStoryCubit>(
          create: (_) => Injectable.getIt<CreateStoryCubit>(),
          child: const Padding(
            padding: EdgeInsets.all(16),
            child: CreateStoryContent(),
          ),
        ),
      ),
    );
  }
}
