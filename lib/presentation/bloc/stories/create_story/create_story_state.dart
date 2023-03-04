part of 'create_story_cubit.dart';

abstract class CreateStoryState extends Equatable {
  const CreateStoryState();

  @override
  List<Object> get props => [];
}

class CreateStoryInitial extends CreateStoryState {}

class CreateStoryLoadingState extends CreateStoryState {}

class CreateStorySuccessState extends CreateStoryState {
  final StoryEntity story;

  const CreateStorySuccessState({
    required this.story,
  });

  @override
  List<Object> get props => [story];
}

class CreateStoryFailureState extends CreateStoryState {
  final String message;

  const CreateStoryFailureState({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
