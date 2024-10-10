import 'package:flutter/material.dart';

@immutable
sealed class ColorRes {
  static const background = Color.fromRGBO(24, 24, 32, 1);
  static const gradient1 = Color.fromRGBO(187, 63, 221, 1);
  static const gradient2 = Color.fromRGBO(251, 109, 169, 1);
  static const gradient3 = Color.fromRGBO(255, 159, 124, 1);
  static const border = Color.fromRGBO(52, 51, 67, 1);
  static const white = Colors.white;
  static const grey = Colors.grey;
  static const blue = Colors.blue;
  static const error = Colors.redAccent;
  static const transparent = Colors.transparent;
}
