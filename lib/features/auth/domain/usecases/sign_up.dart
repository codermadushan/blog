import 'package:flutter/foundation.dart';

import 'package:dartz/dartz.dart';

import '../repositories/auth_repository.dart';
import '../../../../core/common/entities/user_entity.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';

@immutable
class SignUpParam {
  final String name;
  final String email;
  final String password;

  const SignUpParam({
    required this.name,
    required this.email,
    required this.password,
  });
}

@immutable
class SignUp implements UseCase<UserEntity, SignUpParam> {
  final AuthRepository _authRepositoryImpl;

  const SignUp(AuthRepository authRepositoryImpl)
      : _authRepositoryImpl = authRepositoryImpl;

  @override
  Future<Either<Failure, UserEntity>> call(SignUpParam param) async {
    return await _authRepositoryImpl.signUp(
      name: param.name,
      email: param.email,
      password: param.password,
    );
  }
}
