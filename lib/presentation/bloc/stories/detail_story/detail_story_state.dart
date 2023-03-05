part of 'detail_story_cubit.dart';

abstract class DetailStoryState extends Equatable {
  const DetailStoryState();

  @override
  List<Object> get props => [];
}

class DetailStoryInitial extends DetailStoryState {}

class DetailStoryLoadingState extends DetailStoryState {}

class DetailStorySuccessState extends DetailStoryState {
  final StoryEntity story;

  const DetailStorySuccessState({
    required this.story,
  });

  @override
  List<Object> get props => [story];
}

class DetailStoryFailureState extends DetailStoryState {
  final List<String> message;

  const DetailStoryFailureState({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
