import 'package:blog/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../repositories/auth_repository.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/common/entities/user_entity.dart';

@immutable
class SignInParam {
  final String email;
  final String password;

  const SignInParam({
    required this.email,
    required this.password,
  });
}

@immutable
class SignIn implements UseCase<UserEntity, SignInParam> {
  final AuthRepository _authRepositoryImpl;

  const SignIn(AuthRepository authRepositoryImpl)
      : _authRepositoryImpl = authRepositoryImpl;

  @override
  Future<Either<Failure, UserEntity>> call(SignInParam param) async {
    return await _authRepositoryImpl.signIn(
      email: param.email,
      password: param.password,
    );
  }
}
