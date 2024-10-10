import 'package:flutter/foundation.dart';

import 'package:uuid/uuid.dart';

@immutable
class BlogEntity {
  final String posterId;
  final String title;
  final String content;
  final List<String> topics;
  final String? imageUrl;
  final String? posterName;
  final String id;
  final DateTime updatedAt;

  BlogEntity({
    required this.posterId,
    required this.title,
    required this.content,
    required this.topics,
    this.imageUrl,
    this.posterName,
    String? id,
    DateTime? updatedAt,
  })  : id = id ?? const Uuid().v1(),
        updatedAt = updatedAt ?? DateTime.now();
}
