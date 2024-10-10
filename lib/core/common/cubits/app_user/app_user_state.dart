part of 'app_user_cubit.dart';

@immutable
sealed class AppUserState {}

@immutable
final class AppUserInitial extends AppUserState {}

@immutable
final class AppUserLoggedIn extends AppUserState {
  final UserEntity user;

  AppUserLoggedIn(this.user);
}
