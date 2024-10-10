import 'package:flutter/foundation.dart';

import 'package:dartz/dartz.dart';

import '../entities/blog_entity.dart';
import '../repositories/blog_repository.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';

@immutable
class GetAllBlogs implements UseCase<List<BlogEntity>, NoParam> {
  final BlogRepository _blogRepositoryImpl;

  const GetAllBlogs(BlogRepository blogRepositoryImpl)
      : _blogRepositoryImpl = blogRepositoryImpl;

  @override
  Future<Either<Failure, List<BlogEntity>>> call(NoParam param) async {
    return await _blogRepositoryImpl.getAllBlogs();
  }
}
