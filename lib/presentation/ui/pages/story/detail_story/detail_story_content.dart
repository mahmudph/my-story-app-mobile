/*
 * Created by mahmud on Sun Mar 05 2023
 * Email mahmud120398@gmail.com
 * Copyright (c) 2023 mahmud
 * Description
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:my_story_app/presentation/bloc/stories/detail_story/detail_story_cubit.dart';

class DetailStoryContent extends StatefulWidget {
  final int storyId;
  const DetailStoryContent({super.key, required this.storyId});

  @override
  State<DetailStoryContent> createState() => _DetailStoryContentState();
}

class _DetailStoryContentState extends State<DetailStoryContent> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final bloc = BlocProvider.of<DetailStoryCubit>(context, listen: false);
      bloc.handleGetStoryById(widget.storyId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<DetailStoryCubit>(context, listen: false);
    return BlocConsumer(
      bloc: bloc,
      listener: (_, state) {
        if (state is DetailStoryLoadingState) {
          EasyLoading.show();
        } else {
          if (EasyLoading.isShow) EasyLoading.dismiss();
        }
      },
      builder: (_, state) {
        if (state is DetailStorySuccessState) {
        } else if (state is DetailStoryFailureState) {}
        return Container();
      },
    );
  }
}
