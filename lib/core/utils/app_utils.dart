import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:email_validator/email_validator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../res/size_res.dart';
import '../res/string_res.dart';

@immutable
sealed class AppUtils {
  static String? nameValidator(String? name) {
    if (name == null || name.isEmpty) {
      return StringRes.nameEmpty;
    } else if (name.length < 3) {
      return StringRes.nameLengthUnsatisfied;
    } else {
      return null;
    }
  }

  static String? emailValidator(String? email) {
    if (email == null || email.isEmpty) {
      return StringRes.emailEmpty;
    } else if (!EmailValidator.validate(email)) {
      return StringRes.emailInvalid;
    } else {
      return null;
    }
  }

  static String? passwordValidator(String? password) {
    if (password == null || password.isEmpty) {
      return StringRes.passwordEmpty;
    } else if (password.length < 6) {
      return StringRes.passwordLengthUnsatisfied;
    } else {
      return null;
    }
  }

  static String? blogTitleValidator(String? blogTitle) {
    if (blogTitle == null || blogTitle.isEmpty) {
      return StringRes.blogTitleEmpty;
    } else {
      return null;
    }
  }

  static String? blogContentValidator(String? blogContent) {
    if (blogContent == null || blogContent.isEmpty) {
      return StringRes.blogContentEmpty;
    } else {
      return null;
    }
  }

  static void showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static Future<Uint8List?> pickImage() async {
    try {
      final xFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
      );
      return xFile?.readAsBytes();
    } catch (e) {
      return null;
    }
  }

  static int calculateReadingTime(String content) {
    final wordCount = content.split(RegExp(r'\s+')).length;
    final timeInMinutes = wordCount / SizeRes.avgReadingSpeedWPM;
    return timeInMinutes.ceil();
  }

  static String dateFormatter(DateTime dateTime) {
    return DateFormat(StringRes.dateFormat).format(dateTime);
  }
}
