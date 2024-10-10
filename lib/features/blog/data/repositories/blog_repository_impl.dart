import 'package:flutter/foundation.dart';

import 'package:dartz/dartz.dart';

import '../models/blog_model.dart';
import '../sources/blog_remote_source.dart';
import '../../domain/entities/blog_entity.dart';
import '../../domain/repositories/blog_repository.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/error/server_exception.dart';

@immutable
class BlogRepositoryImpl implements BlogRepository {
  final BlogRemoteSource _blogRemoteSourceImpl;

  const BlogRepositoryImpl({
    required BlogRemoteSource blogRemoteSourceImpl,
  }) : _blogRemoteSourceImpl = blogRemoteSourceImpl;

  @override
  Future<Either<Failure, BlogEntity>> uploadBlog({
    required String posterId,
    required String title,
    required String content,
    required List<String> topics,
    required Uint8List? image,
  }) async {
    try {
      BlogModel blogModel = BlogModel(
        posterId: posterId,
        title: title,
        content: content,
        topics: topics,
      );
      if (image != null) {
        final imageUrl = await _blogRemoteSourceImpl.uploadBlogImage(
          image: image,
          blogModel: blogModel,
        );
        blogModel = blogModel.copyWith(imageUrl: imageUrl);
      }
      blogModel = await _blogRemoteSourceImpl.uploadBlog(blogModel);
      return right(blogModel);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<BlogEntity>>> getAllBlogs() async {
    try {
      final blogModels = await _blogRemoteSourceImpl.getAllBlogs();
      return right(blogModels);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
