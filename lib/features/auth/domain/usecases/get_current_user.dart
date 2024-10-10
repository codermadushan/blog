import 'package:flutter/foundation.dart';

import 'package:dartz/dartz.dart';

import '../repositories/auth_repository.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/common/entities/user_entity.dart';

@immutable
class GetCurrentUser implements UseCase<UserEntity, NoParam> {
  final AuthRepository _authRepositoryImpl;

  const GetCurrentUser(AuthRepository authRepositoryImpl)
      : _authRepositoryImpl = authRepositoryImpl;

  @override
  Future<Either<Failure, UserEntity>> call(NoParam param) async {
    return await _authRepositoryImpl.getCurrentUser();
  }
}
