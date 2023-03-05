/*
 * Created by mahmud on Sun Mar 05 2023
 * Email mahmud120398@gmail.com
 * Copyright (c) 2023 mahmud
 * Description
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_story_app/presentation/bloc/bloc.dart' show DetailStoryCubit;
import 'package:my_story_app/utils/injectable.dart';

import 'detail_story_content.dart';

class DetailStoryScreen extends StatelessWidget {
  const DetailStoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final storyId = ModalRoute.of(context)!.settings.arguments! as int;

    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (_) => Injectable.getIt<DetailStoryCubit>(),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: DetailStoryContent(storyId: storyId),
          ),
        ),
      ),
    );
  }
}
