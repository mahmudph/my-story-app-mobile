part of 'user_cubit.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserLoadingState extends UserState {}

class UserSuccessState extends UserState {
  final UserEntity user;

  const UserSuccessState({required this.user});

  @override
  List<Object> get props => [user];
}

class UserFailureState extends UserState {
  final String message;

  const UserFailureState({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

class UserLogoutStatusState extends UserState {
  final String message;
  final bool isSuccess;

  const UserLogoutStatusState({
    required this.message,
    this.isSuccess = true,
  });
}
