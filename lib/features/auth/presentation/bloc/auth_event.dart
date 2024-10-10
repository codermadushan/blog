part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

@immutable
final class AuthSignUp extends AuthEvent {
  final String name;
  final String email;
  final String password;

  AuthSignUp({
    required this.name,
    required this.email,
    required this.password,
  });
}

@immutable
final class AuthSignIn extends AuthEvent {
  final String email;
  final String password;

  AuthSignIn({
    required this.email,
    required this.password,
  });
}

@immutable
final class AuthGetCurrentUser extends AuthEvent {}

@immutable
final class AuthSignOut extends AuthEvent {}
