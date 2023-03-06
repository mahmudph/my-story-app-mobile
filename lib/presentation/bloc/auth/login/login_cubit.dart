import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_story_app/common/failure.dart';
import 'package:my_story_app/domain/usecase/auth/login_usecase.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase login;

  LoginCubit({
    required this.login,
  }) : super(LoginInitial());

  Future<void> handleUserLogin(Map<String, dynamic> data) async {
    emit(LoginLoadingState());
    final result = await login.invoke(data);

    result.fold(
      (failure) {
        /**
         * since the error is always be ServerFailure in
         * the login process then we need to bind 
         */
        final failureData = failure as ServerFailure;
        emit(
          LoginFailureState(
            messages: failureData.message,
            errorFormFields: failureData.errorFields,
          ),
        );
      },
      (data) => emit(LoginSuccessState()),
    );
  }
}
