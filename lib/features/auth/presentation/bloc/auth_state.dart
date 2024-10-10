part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

@immutable
final class AuthInitial extends AuthState {}

@immutable
final class AuthLoading extends AuthState {}

@immutable
final class AuthSuccess extends AuthState {}

@immutable
final class AuthFailure extends AuthState {
  final String message;

  AuthFailure(this.message);
}
