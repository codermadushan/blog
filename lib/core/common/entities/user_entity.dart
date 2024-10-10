import 'package:flutter/material.dart';

@immutable
class UserEntity {
  final String userId;
  final String name;
  final String email;

  const UserEntity({
    required this.userId,
    required this.name,
    required this.email,
  });
}
