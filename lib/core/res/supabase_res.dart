import 'package:flutter/foundation.dart';

@immutable
sealed class SupabaseRes {
  static const blogImageBucketId = 'blog_images';
  static const blogTableName = 'blogs';
  static const profileTableName = 'profiles';

  static const name = 'name';
  static const id = 'id';
  static const posterId = 'poster_id';
  static const title = 'title';
  static const content = 'content';
  static const updatedAt = 'updated_at';
  static const imageUrl = 'image_url';
  static const topics = 'topics';

  static const allBlogSelectLogic = '*, profiles (name)';
}
