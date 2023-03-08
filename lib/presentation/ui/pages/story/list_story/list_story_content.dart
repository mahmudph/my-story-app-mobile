/*
 * Created by mahmud on Sun Mar 05 2023
 * Email mahmud120398@gmail.com
 * Copyright (c) 2023 mahmud
 * Description
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_story_app/presentation/routes/routes.dart';
import 'package:my_story_app/presentation/ui/widgets/info_widget.dart';
import 'package:my_story_app/presentation/ui/widgets/story_item_widget.dart';
import 'package:my_story_app/presentation/bloc/stories/list_story/list_story_cubit.dart';

class ListStoryContent extends StatelessWidget {
  const ListStoryContent({super.key});

  void showBottomSheetAction(
    BuildContext context,
    ListStoryCubit bloc,
    id,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.browse_gallery),
              title: Text(
                "See detail story",
                style: GoogleFonts.poppins(fontSize: 12),
              ),
              onTap: () {
                Navigator.popAndPushNamed(
                  context,
                  RouteName.showStory,
                  arguments: id,
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.browse_gallery),
              title: Text(
                "Delete story",
                style: GoogleFonts.poppins(fontSize: 12),
              ),
              onTap: () {
                bloc.deleteStories(id);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<ListStoryCubit>(context, listen: false);
    return RefreshIndicator(
      onRefresh: () async => bloc.loadStoriesList(),
      child: BlocConsumer<ListStoryCubit, ListStoryState>(
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
        buildWhen: (preState, nextState) {
          return nextState is! ListStoryLoadingState;
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
                  onPress: () => showBottomSheetAction(
                    context,
                    bloc,
                    state.stories[i].id,
                  ),
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
      ),
    );
  }
}
