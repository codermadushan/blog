import 'package:flutter/material.dart';

import '../../../../core/common/entities/user_entity.dart';

@immutable
class UserModel extends UserEntity {
  const UserModel({
    required super.userId,
    required super.name,
    required super.email,
  });
}
