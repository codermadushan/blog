import 'package:flutter/foundation.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/blog_entity.dart';
import '../../domain/usecases/get_all_blogs.dart';
import '../../domain/usecases/upload_blog.dart';
import '../../../../core/usecase/usecase.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlog _uploadBlog;
  final GetAllBlogs _getAllBlogs;

  BlogBloc({
    required UploadBlog uploadBlog,
    required GetAllBlogs getAllBlogs,
  })  : _uploadBlog = uploadBlog,
        _getAllBlogs = getAllBlogs,
        super(BlogInitial()) {
    on<BlogUploadBlog>(_onBlogUploadBlog);
    on<BlogGetAllBlogs>(_onBlogGetAllBlogs);
  }

  Future<void> _onBlogUploadBlog(
    BlogUploadBlog event,
    Emitter<BlogState> emit,
  ) async {
    emit(BlogLoading());
    final param = UploadBlogParam(
      posterId: event.posterId,
      title: event.title,
      content: event.content,
      topics: event.topics,
      image: event.image,
    );
    final response = await _uploadBlog.call(param);
    response.fold(
      (failure) => emit(BlogFailure(failure.message)),
      (blogEntity) => emit(BlogUploadSuccess()),
    );
  }

  Future<void> _onBlogGetAllBlogs(
    BlogGetAllBlogs event,
    Emitter<BlogState> emit,
  ) async {
    emit(BlogLoading());
    final response = await _getAllBlogs.call(NoParam());
    response.fold(
      (failure) => emit(BlogFailure(failure.message)),
      (blogEntities) => emit(BlogGetAllBlogsSuccess(blogEntities)),
    );
  }

  @override
  void onChange(Change<BlogState> change) {
    if (change.nextState is BlogUploadSuccess) {
      add(BlogGetAllBlogs());
    }
    super.onChange(change);
  }
}
