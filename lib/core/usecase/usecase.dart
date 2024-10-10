import 'package:flutter/foundation.dart';

import 'package:dartz/dartz.dart';

import '../error/failure.dart';

@immutable
class NoParam {}

@immutable
abstract interface class UseCase<SuccessType, ParamType> {
  Future<Either<Failure, SuccessType>> call(ParamType param);
}
