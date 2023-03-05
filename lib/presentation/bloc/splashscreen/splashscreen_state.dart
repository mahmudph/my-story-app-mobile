part of 'splashscreen_cubit.dart';

abstract class SplashscreenState extends Equatable {
  const SplashscreenState();

  @override
  List<Object> get props => [];
}

class SplashscreenInitial extends SplashscreenState {}

class SplashscreenAuthState extends SplashscreenState {
  final bool isAlreadyLoginUser;

  const SplashscreenAuthState({
    this.isAlreadyLoginUser = false,
  });
}
