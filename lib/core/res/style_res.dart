import 'package:flutter/material.dart';

import 'color_res.dart';

@immutable
sealed class StyleRes {
  static const titleLarge = TextStyle(
    fontSize: 57,
    fontWeight: FontWeight.bold,
  );

  static const hintText = TextStyle(
    color: ColorRes.grey,
  );

  static const btnLabel = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 18,
  );

  static const link = TextStyle(
    fontWeight: FontWeight.bold,
    color: ColorRes.blue,
  );

  static const bodyLarge = TextStyle(
    fontSize: 16,
  );

  static const blogCardTitle = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
  );

  static const blogViewTitle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  static const blogViewPoster = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  static const blogViewDate = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: ColorRes.grey,
  );
}
