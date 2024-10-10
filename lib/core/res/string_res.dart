import 'package:flutter/foundation.dart';

@immutable
sealed class StringRes {
  // Hints
  static const hintName = 'Enter name';
  static const hintEmail = 'Enter email';
  static const hintPassword = 'Enter password';
  static const hintBlogTitle = 'Blog title';
  static const hintBlogContent = 'Blog content';

  // Error messages
  static const nameEmpty = 'Name is required';
  static const nameLengthUnsatisfied = 'Name should have least 3 characters';
  static const emailEmpty = 'Email is required';
  static const emailInvalid = 'Not a valid email';
  static const passwordEmpty = 'Password is required';
  static const passwordLengthUnsatisfied =
      'Password should have least 6 characters';
  static const nullUser = 'User is null';
  static const defaultError = 'Something went wrong';
  static const blogTitleEmpty = 'Blog title required';
  static const blogContentEmpty = 'Blog content required';

  // SignInPage
  static const signInLabel = 'Sign in';
  static const isntThereAccount = 'Don\'t have an account?';

  // SignUpPage
  static const signUpLabel = 'Sign up';
  static const isThereAccount = 'Already have an account?';

  // BlogPage
  static const blogPageTitle = 'Blog App';

  // AddNewBlogPage
  static const selectImage = 'Select your image';

  // Chips
  static const chipEntertainment = 'Entertainment';
  static const chipBusiness = 'Business';
  static const chipProgramming = 'Programming';
  static const chipTechnology = 'Technology';

  static const dateFormat = 'd MMM, yyyy';
}
