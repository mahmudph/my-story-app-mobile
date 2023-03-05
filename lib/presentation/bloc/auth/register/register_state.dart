part of 'register_cubit.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {}

class RegisterLoadingState extends RegisterState {}

class RegisterSuccessState extends RegisterState {
  final UserEntity user;
  const RegisterSuccessState({required this.user});

  @override
  List<Object> get props => [user];
}

class RegisterFailureState extends RegisterState {
  final String messaage;
  final Map<String, List<String>>? errorFormField;
  const RegisterFailureState({
    required this.messaage,
    this.errorFormField,
  });

  @override
  List<Object> get props => [messaage];
}
