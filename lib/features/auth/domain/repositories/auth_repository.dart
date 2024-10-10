import 'package:flutter/material.dart';

import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/common/entities/user_entity.dart';

@immutable
abstract interface class AuthRepository {
  Future<Either<Failure, UserEntity>> signUp({
    required String name,
    required String email,
    required String password,
  });

  Future<Either<Failure, UserEntity>> signIn({
    required String email,
    required String password,
  });

  Future<Either<Failure, UserEntity>> getCurrentUser();

  Future<Either<Failure, void>> signOut();
}
