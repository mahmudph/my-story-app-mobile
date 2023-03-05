import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_story_app/domain/entities/story_entity.dart';
import 'package:my_story_app/domain/usecase/usecase.dart';

part 'list_story_state.dart';

class ListStoryCubit extends Cubit<ListStoryState> {
  final GetStoriesUseCase getStoriesUseCase;

  ListStoryCubit({
    required this.getStoriesUseCase,
  }) : super(ListStoryInitial()) {
    Future.delayed(const Duration(seconds: 1)).then((_) => loadStoriesList());
  }

  Future<void> loadStoriesList() async {
    emit(ListStoryLoadingState());
    final result = await getStoriesUseCase.invoke();

    result.fold(
      (failure) => emit(ListStoryFailureState(message: failure.message)),
      (data) => emit(ListStorySuccessState(stories: data)),
    );
  }
}
