/*
 * Created by mahmud on Sun Mar 05 2023
 * Email mahmud120398@gmail.com
 * Copyright (c) 2023 mahmud
 * Description
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:my_story_app/presentation/routes/routes.dart';
import 'package:my_story_app/presentation/ui/widgets/info_widget.dart';
import 'package:my_story_app/presentation/ui/widgets/story_item_widget.dart';
import 'package:my_story_app/presentation/bloc/stories/list_story/list_story_cubit.dart';

class ListStoryContent extends StatelessWidget {
  const ListStoryContent({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<ListStoryCubit>(context, listen: false);
    return BlocConsumer<ListStoryCubit, ListStoryState>(
      bloc: bloc,
      listener: (_, state) {
        if (state is ListStoryLoadingState) {
          EasyLoading.show();
        } else if (state is ListStorySuccessState) {
          if (EasyLoading.isShow) EasyLoading.dismiss();
        } else if (state is ListStoryFailureState) {
          if (EasyLoading.isShow) EasyLoading.dismiss();
          EasyLoading.showError(state.message);
        }
      },
      builder: (_, state) {
        if (state is ListStorySuccessState) {
          if (state.stories.isEmpty) {
            return const InfoWidget(
              title: "Data Not Found",
              message:
                  "Data Story not found, all stories will be show hire when you have added",
            );
          }
          return ListView.separated(
            itemBuilder: (_, i) {
              return StoryItemWidget(
                story: state.stories[i],
                onPress: () {
                  Navigator.pushNamed(
                    context,
                    RouteName.showStory,
                    arguments: state.stories[i].id,
                  );
                },
              );
            },
            separatorBuilder: (_, i) => const SizedBox(height: 3),
            itemCount: state.stories.length,
          );
        } else if (state is ListStoryFailureState) {
          return Text(state.message);
        }
        return Container();
      },
    );
  }
}
