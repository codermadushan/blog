import 'package:flutter/material.dart';

import '../../features/auth/presentation/pages/sign_in_page.dart';
import '../../features/auth/presentation/pages/sign_up_page.dart';
import '../../features/blog/presentation/pages/add_new_blog_page.dart';
import '../../features/blog/presentation/pages/blog_page.dart';
import '../../features/blog/presentation/pages/blog_view_page.dart';

@immutable
sealed class AppRoute {
  static const signUpPage = '/sign_up_page';
  static const signInPage = '/sign_in_page';
  static const blogPage = '/blog_page';
  static const addNewBlogPage = '/add_new_blog_page';
  static const blogViewPage = '/blog_view_page';

  static Map<String, Widget Function(BuildContext)> get routes {
    return {
      signUpPage: (context) => const SignUpPage(),
      signInPage: (context) => const SignInPage(),
      blogPage: (context) => const BlogPage(),
      addNewBlogPage: (context) => const AddNewBlogPage(),
      blogViewPage: (context) => const BlogViewPage(),
    };
  }
}
