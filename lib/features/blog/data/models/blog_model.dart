import 'package:flutter/foundation.dart';

import '../../domain/entities/blog_entity.dart';
import '../../../../core/res/supabase_res.dart';

@immutable
class BlogModel extends BlogEntity {
  BlogModel({
    required super.posterId,
    required super.title,
    required super.content,
    required super.topics,
    super.imageUrl,
    super.posterName,
    super.id,
    super.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      SupabaseRes.id: id,
      SupabaseRes.posterId: posterId,
      SupabaseRes.title: title,
      SupabaseRes.content: content,
      SupabaseRes.updatedAt: updatedAt.toIso8601String(),
      SupabaseRes.imageUrl: imageUrl,
      SupabaseRes.topics: topics,
    };
  }

  factory BlogModel.fromMap(Map<String, dynamic> map) {
    return BlogModel(
      id: map[SupabaseRes.id],
      posterId: map[SupabaseRes.posterId],
      title: map[SupabaseRes.title],
      content: map[SupabaseRes.content],
      imageUrl: map[SupabaseRes.imageUrl],
      topics: List<String>.from(map[SupabaseRes.topics]),
      updatedAt: DateTime.parse(map[SupabaseRes.updatedAt]),
    );
  }

  BlogModel copyWith({
    String? posterId,
    String? title,
    String? content,
    List<String>? topics,
    String? imageUrl,
    String? posterName,
    String? id,
    DateTime? updatedAt,
  }) {
    return BlogModel(
      posterId: posterId ?? this.posterId,
      title: title ?? this.title,
      content: content ?? this.content,
      topics: topics ?? this.topics,
      imageUrl: imageUrl ?? this.imageUrl,
      posterName: posterName ?? this.posterName,
      id: id ?? this.id,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
