import 'package:flutter/foundation.dart';

import 'package:dartz/dartz.dart';

import '../entities/blog_entity.dart';
import '../../../../core/error/failure.dart';

@immutable
abstract interface class BlogRepository {
  Future<Either<Failure, BlogEntity>> uploadBlog({
    required String posterId,
    required String title,
    required String content,
    required List<String> topics,
    required Uint8List? image,
  });

  Future<Either<Failure, List<BlogEntity>>> getAllBlogs();
}
