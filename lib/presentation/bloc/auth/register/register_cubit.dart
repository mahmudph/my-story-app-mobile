import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_story_app/common/failure.dart';
import 'package:my_story_app/domain/entities/user_entity.dart';
import 'package:my_story_app/domain/usecase/usecase.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterUseCase registerUseCase;

  RegisterCubit({
    required this.registerUseCase,
  }) : super(RegisterInitial());

  Future<void> handleUserRegister(Map<String, dynamic> data) async {
    emit(RegisterLoadingState());
    final result = await registerUseCase.invoke(data);

    result.fold(
      (failure) {
        final failureData = failure as ServerFailure;
        emit(
          RegisterFailureState(
            messaage: failureData.message,
            errorFormField: failureData.errorFields,
          ),
        );
      },
      (data) => emit(RegisterSuccessState(user: data)),
    );
  }
}
