import 'package:flutter/foundation.dart';

import 'package:dartz/dartz.dart';

import '../entities/blog_entity.dart';
import '../repositories/blog_repository.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';

@immutable
class UploadBlogParam {
  final String posterId;
  final String title;
  final String content;
  final List<String> topics;
  final Uint8List? image;

  const UploadBlogParam({
    required this.posterId,
    required this.title,
    required this.content,
    required this.topics,
    this.image,
  });
}

@immutable
class UploadBlog implements UseCase<BlogEntity, UploadBlogParam> {
  final BlogRepository _blogRepositoryImpl;

  const UploadBlog(BlogRepository blogRepositoryImpl)
      : _blogRepositoryImpl = blogRepositoryImpl;

  @override
  Future<Either<Failure, BlogEntity>> call(UploadBlogParam param) async {
    return await _blogRepositoryImpl.uploadBlog(
      posterId: param.posterId,
      title: param.title,
      content: param.content,
      topics: param.topics,
      image: param.image,
    );
  }
}
