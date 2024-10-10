import 'package:flutter/foundation.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/blog_model.dart';
import '../../../../core/res/supabase_res.dart';
import '../../../../core/res/string_res.dart';
import '../../../../core/error/server_exception.dart';

@immutable
abstract interface class BlogRemoteSource {
  Future<BlogModel> uploadBlog(BlogModel blogModel);

  Future<String> uploadBlogImage({
    required Uint8List image,
    required BlogModel blogModel,
  });

  Future<List<BlogModel>> getAllBlogs();
}

@immutable
class BlogRemoteSourceImpl implements BlogRemoteSource {
  final SupabaseClient _supabaseClient;

  const BlogRemoteSourceImpl(SupabaseClient supabaseClient)
      : _supabaseClient = supabaseClient;

  @override
  Future<BlogModel> uploadBlog(BlogModel blogModel) async {
    try {
      final data = await _supabaseClient
          .from(SupabaseRes.blogTableName)
          .insert(blogModel.toMap())
          .select();
      return BlogModel.fromMap(data.first);
    } catch (e) {
      throw const ServerException(StringRes.defaultError);
    }
  }

  @override
  Future<String> uploadBlogImage({
    required Uint8List image,
    required BlogModel blogModel,
  }) async {
    try {
      await _supabaseClient.storage
          .from(SupabaseRes.blogImageBucketId)
          .uploadBinary(blogModel.id, image);
      final imageUrl = _supabaseClient.storage
          .from(SupabaseRes.blogImageBucketId)
          .getPublicUrl(blogModel.id);
      return imageUrl;
    } catch (e) {
      throw const ServerException(StringRes.defaultError);
    }
  }

  @override
  Future<List<BlogModel>> getAllBlogs() async {
    try {
      final maps = await _supabaseClient
          .from(SupabaseRes.blogTableName)
          .select(SupabaseRes.allBlogSelectLogic);
      final blogModels = maps.map((map) {
        final posterName = map[SupabaseRes.profileTableName][SupabaseRes.name];
        return BlogModel.fromMap(map).copyWith(posterName: posterName);
      }).toList();
      return blogModels;
    } catch (e) {
      throw const ServerException(StringRes.defaultError);
    }
  }
}
