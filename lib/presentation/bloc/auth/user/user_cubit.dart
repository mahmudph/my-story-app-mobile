import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_story_app/domain/entities/user_entity.dart';
import 'package:my_story_app/domain/usecase/auth/profile_usecase.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final ProfileUseCase profileUseCase;

  UserCubit({
    required this.profileUseCase,
  }) : super(UserInitial());

  Future<void> loadUserProfile() async {
    emit(UserLoadingState());
    final result = await profileUseCase.invoke();

    result.fold(
      (failure) => emit(UserFailureState(message: failure.message)),
      (data) => emit(UserSuccessState(user: data)),
    );
  }
}
