import 'package:flutter/foundation.dart';

@immutable
sealed class SizeRes {
  static const pagePadding = 16.0;
  static const defaultIconSize = 24.0;
  static const avgReadingSpeedWPM = 225.0;

  static const authFieldBorderWidth = 2.0;
  static const authFieldBorderRadius = 8.0;
  static const authFieldPadding = 18.0;

  static const gapLarge = 45.0;
  static const gapMedium = 22.0;
  static const gapSmall = 11.0;

  static const mainButtonHeight = 57.0;
  static const mainButtonBorderRadius = 8.0;
  static const mainButtonLoaderSize = 28.0;

  // AddNewBlogPage
  static const selectImageBoxHeight = 150.0;
  static const selectImageBoxBorderRadius = 11.0;
  static const selectImageBoxIconSize = 40.0;
  static const blogChipCount = 4;

  // BlogCard
  static const blogCardHeight = 200.0;
  static const blogCardBorderRadius = 11.0;
}
