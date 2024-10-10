part of 'blog_bloc.dart';

@immutable
sealed class BlogState {}

@immutable
final class BlogInitial extends BlogState {}

@immutable
final class BlogLoading extends BlogState {}

@immutable
final class BlogFailure extends BlogState {
  final String message;

  BlogFailure(this.message);
}

@immutable
final class BlogUploadSuccess extends BlogState {}

@immutable
final class BlogGetAllBlogsSuccess extends BlogState {
  final List<BlogEntity> blogEntities;

  BlogGetAllBlogsSuccess(this.blogEntities);
}
