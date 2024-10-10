import 'package:flutter/foundation.dart';

import 'package:dartz/dartz.dart';

import '../sources/auth_remote_source.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../../../core/common/entities/user_entity.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/error/server_exception.dart';

@immutable
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteSource _authRemoteSourceImpl;

  const AuthRepositoryImpl(AuthRemoteSource authRemoteSourceImpl)
      : _authRemoteSourceImpl = authRemoteSourceImpl;

  @override
  Future<Either<Failure, UserEntity>> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final userModel = await _authRemoteSourceImpl.signUp(
        name: name,
        email: email,
        password: password,
      );
      return right(userModel);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final userModel = await _authRemoteSourceImpl.signIn(
        email: email,
        password: password,
      );
      return right(userModel);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getCurrentUser() async {
    try {
      final userModel = await _authRemoteSourceImpl.getCurrentUser();
      return right(userModel);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      final data = await _authRemoteSourceImpl.signOut();
      return right(data);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
