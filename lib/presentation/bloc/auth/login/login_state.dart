part of 'login_cubit.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {}

class LoginFailureState extends LoginState {
  final String messages;
  final Map<String, List<String>>? errorFormFields;

  const LoginFailureState({
    required this.messages,
    this.errorFormFields,
  });

  @override
  List<Object> get props => [messages];
}
