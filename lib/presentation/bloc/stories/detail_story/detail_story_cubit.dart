import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_story_app/domain/entities/story_entity.dart';
import 'package:my_story_app/domain/usecase/usecase.dart';

part 'detail_story_state.dart';

class DetailStoryCubit extends Cubit<DetailStoryState> {
  final GetStoryUseCase getStoryUseCase;

  DetailStoryCubit({
    required this.getStoryUseCase,
  }) : super(DetailStoryInitial());

  Future<void> handleGetStoryById(int id) async {
    await Future.delayed(const Duration(seconds: 2));

    emit(DetailStoryLoadingState());
    final result = await getStoryUseCase.invoke(id);

    result.fold(
      (failure) => emit(
        DetailStoryFailureState(message: failure.message.split(',')),
      ),
      (data) => emit(DetailStorySuccessState(story: data)),
    );
  }
}
