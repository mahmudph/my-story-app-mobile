import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_story_app/domain/entities/story_entity.dart';
import 'package:my_story_app/domain/usecase/usecase.dart';

part 'create_story_state.dart';

class CreateStoryCubit extends Cubit<CreateStoryState> {
  final CreateStoryUseCase createStoryUseCase;

  CreateStoryCubit({
    required this.createStoryUseCase,
  }) : super(CreateStoryInitial());

  Future<void> handleCreateStory(Map<String, dynamic> data) async {
    emit(CreateStoryLoadingState());
    final result = await createStoryUseCase.invoke(data);

    result.fold(
      (failure) => emit(CreateStoryFailureState(message: failure.message)),
      (data) => emit(CreateStorySuccessState(story: data)),
    );
  }
}
