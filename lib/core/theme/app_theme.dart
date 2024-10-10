import 'package:flutter/material.dart';

import '../res/color_res.dart';
import '../res/size_res.dart';

@immutable
sealed class AppTheme {
  static OutlineInputBorder _border(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(SizeRes.authFieldBorderRadius),
      borderSide: BorderSide(
        width: SizeRes.authFieldBorderWidth,
        color: color,
      ),
    );
  }

  static final dark = ThemeData.dark().copyWith(
    //
    scaffoldBackgroundColor: ColorRes.background,

    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(SizeRes.authFieldPadding),
      enabledBorder: _border(ColorRes.border),
      focusedBorder: _border(ColorRes.gradient2),
      errorBorder: _border(ColorRes.error),
      focusedErrorBorder: _border(ColorRes.error),
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: ColorRes.background,
    ),

    chipTheme: const ChipThemeData(
      backgroundColor: ColorRes.background,
      side: BorderSide(color: ColorRes.border),
    ),
  );
}
