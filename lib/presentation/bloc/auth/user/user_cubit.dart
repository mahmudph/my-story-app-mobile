import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_story_app/domain/entities/user_entity.dart';
import 'package:my_story_app/domain/usecase/auth/logout_usecase.dart';
import 'package:my_story_app/domain/usecase/auth/profile_usecase.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final ProfileUseCase profileUseCase;
  final LogoutUseCase logoutUseCase;

  UserCubit({
    required this.logoutUseCase,
    required this.profileUseCase,
  }) : super(UserInitial()) {
    /// load user profile
    Future.delayed(const Duration(milliseconds: 500)).then(
      (_) => loadUserProfile(),
    );
  }

  Future<void> loadUserProfile() async {
    emit(UserLoadingState());
    final result = await profileUseCase.invoke();

    result.fold(
      (failure) => emit(UserFailureState(message: failure.message)),
      (data) => emit(UserSuccessState(user: data)),
    );
  }

  Future<void> handleOnUserLogout() async {
    emit(UserLoadingState());

    await Future.delayed(const Duration(seconds: 2));
    final result = await logoutUseCase.invoke();

    result.fold(
      (failure) => emit(UserLogoutStatusState(message: failure.message)),
      (data) => emit(UserLogoutStatusState(message: data, isSuccess: true)),
    );
  }
}
