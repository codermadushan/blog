part of 'blog_bloc.dart';

@immutable
sealed class BlogEvent {}

@immutable
final class BlogUploadBlog extends BlogEvent {
  final String posterId;
  final String title;
  final String content;
  final List<String> topics;
  final Uint8List? image;

  BlogUploadBlog({
    required this.posterId,
    required this.title,
    required this.content,
    required this.topics,
    this.image,
  });
}

@immutable
final class BlogGetAllBlogs extends BlogEvent {}
