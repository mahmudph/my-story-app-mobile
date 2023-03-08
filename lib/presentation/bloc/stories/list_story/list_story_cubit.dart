import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_story_app/domain/entities/story_entity.dart';
import 'package:my_story_app/domain/usecase/usecase.dart';

part 'list_story_state.dart';

class ListStoryCubit extends Cubit<ListStoryState> {
  final GetStoriesUseCase getStoriesUseCase;
  final DeleteStoryUseCase deleteStoryUseCase;

  ListStoryCubit({
    required this.getStoriesUseCase,
    required this.deleteStoryUseCase,
  }) : super(ListStoryInitial()) {
    Future.delayed(const Duration(milliseconds: 100)).then(
      (_) => loadStoriesList(),
    );
  }

  Future<void> loadStoriesList() async {
    emit(ListStoryLoadingState());
    final result = await getStoriesUseCase.invoke();

    result.fold(
      (failure) => emit(ListStoryFailureState(message: failure.message)),
      (data) => emit(ListStorySuccessState(stories: data)),
    );
  }

  Future<void> deleteStories(int id) async {
    /**
     * get the current ListStorySuccessState
     */
    final currentStateSuccess = state as ListStorySuccessState;

    emit(ListStoryLoadingState());
    final result = await deleteStoryUseCase.invoke(id);

    result.fold(
      (failure) => emit(ListStoryFailureState(message: failure.message)),
      (data) {
        emit(
          currentStateSuccess.copyWith(
            stories: currentStateSuccess.stories
                .where((story) => story.id != id)
                .toList(),
          ),
        );
      },
    );
  }
}
