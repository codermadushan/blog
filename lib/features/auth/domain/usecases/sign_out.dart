import 'package:dartz/dartz.dart';

import '../repositories/auth_repository.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';

class SignOut implements UseCase<void, NoParam> {
  final AuthRepository _authRepositoryImpl;

  const SignOut(AuthRepository authRepositoryImpl)
      : _authRepositoryImpl = authRepositoryImpl;

  @override
  Future<Either<Failure, void>> call(NoParam param) async {
    return await _authRepositoryImpl.signOut();
  }
}
