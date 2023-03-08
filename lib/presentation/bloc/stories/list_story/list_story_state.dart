part of 'list_story_cubit.dart';

abstract class ListStoryState extends Equatable {
  const ListStoryState();

  @override
  List<Object> get props => [];
}

class ListStoryInitial extends ListStoryState {}

class ListStoryLoadingState extends ListStoryState {}

class ListStorySuccessState extends ListStoryState {
  final List<StoryEntity> stories;

  const ListStorySuccessState({required this.stories});

  @override
  List<Object> get props => [stories];

  ListStorySuccessState copyWith({List<StoryEntity>? stories}) {
    return ListStorySuccessState(stories: stories ?? this.stories);
  }
}

class ListStoryFailureState extends ListStoryState {
  final String message;

  const ListStoryFailureState({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
