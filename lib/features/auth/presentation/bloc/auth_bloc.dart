import 'package:flutter/foundation.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_current_user.dart';
import '../../domain/usecases/sign_in.dart';
import '../../domain/usecases/sign_out.dart';
import '../../domain/usecases/sign_up.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/common/cubits/app_user/app_user_cubit.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignUp _signUp;
  final SignIn _signIn;
  final GetCurrentUser _getCurrentUser;
  final AppUserCubit _appUserCubit;
  final SignOut _signOut;

  AuthBloc({
    required SignUp signUp,
    required SignIn signIn,
    required GetCurrentUser getCurrentUser,
    required AppUserCubit appUserCubit,
    required SignOut signOut,
  })  : _signUp = signUp,
        _signIn = signIn,
        _getCurrentUser = getCurrentUser,
        _appUserCubit = appUserCubit,
        _signOut = signOut,
        super(AuthInitial()) {
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthSignIn>(_onAuthSignIn);
    on<AuthGetCurrentUser>(_onAuthGetCurrentUser);
    on<AuthSignOut>(_onAuthSignOut);
  }

  Future<void> _onAuthSignUp(
    AuthSignUp event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final signUpParam = SignUpParam(
      name: event.name,
      email: event.email,
      password: event.password,
    );
    final response = await _signUp.call(signUpParam);
    response.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (userEntity) {
        emit(AuthSuccess());
        _appUserCubit.updateUser(userEntity);
      },
    );
  }

  Future<void> _onAuthSignIn(
    AuthSignIn event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final param = SignInParam(
      email: event.email,
      password: event.password,
    );
    final response = await _signIn.call(param);
    response.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (userEntity) {
        emit(AuthSuccess());
        _appUserCubit.updateUser(userEntity);
      },
    );
  }

  Future<void> _onAuthGetCurrentUser(
    AuthGetCurrentUser event,
    Emitter<AuthState> emit,
  ) async {
    final response = await _getCurrentUser.call(NoParam());
    response.fold(
      (failure) {},
      (userEntity) {
        emit(AuthSuccess());
        _appUserCubit.updateUser(userEntity);
      },
    );
  }

  Future<void> _onAuthSignOut(
    AuthSignOut event,
    Emitter<AuthState> emit,
  ) async {
    final response = await _signOut.call(NoParam());
    response.fold(
      (l) {},
      (_) => emit(AuthInitial()),
    );
  }
}
