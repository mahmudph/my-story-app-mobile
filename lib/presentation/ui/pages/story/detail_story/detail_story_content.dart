/*
 * Created by mahmud on Sun Mar 05 2023
 * Email mahmud120398@gmail.com
 * Copyright (c) 2023 mahmud
 * Description
 */
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:my_story_app/presentation/bloc/stories/detail_story/detail_story_cubit.dart';
import 'package:my_story_app/presentation/ui/widgets/content_widget.dart';
import 'package:my_story_app/presentation/ui/widgets/info_widget.dart';

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
    final size = MediaQuery.of(context).size;
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
          final createdAt = DateFormat.yMMMd();
          return SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: size.width * 0.4,
                  width: size.width * 0.4,
                  child: Image.asset(
                    'assets/images/avatar.png',
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 16),
                ContentWidget(
                  text: "Title:\n${state.story.title}",
                ),
                ContentWidget(
                  text: "Category:\n${state.story.category.name}",
                ),
                ContentWidget(
                  text:
                      "Created by:\n${state.story.user.name} - ${createdAt.format(state.story.createdAt)}",
                ),
                ContentWidget(
                  text: "Description:\n${state.story.description}",
                ),
              ],
            ),
          );
        } else if (state is DetailStoryFailureState) {
          return const InfoWidget(
            title: "Process failure",
            message: "Get Story detail failure,please try again later",
          );
        }
        return Container();
      },
    );
  }
}
