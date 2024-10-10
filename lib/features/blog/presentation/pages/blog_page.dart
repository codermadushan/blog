import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/blog_bloc.dart';
import '../widgets/blog_card.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../../core/res/size_res.dart';
import '../../../../core/res/color_res.dart';
import '../../../../core/utils/app_utils.dart';
import '../../../../core/res/string_res.dart';
import '../../../../core/route/app_route.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  late final AuthBloc _authBloc;
  late final BlogBloc _blogBloc;

  @override
  void initState() {
    _authBloc = context.read<AuthBloc>();
    _blogBloc = context.read<BlogBloc>();
    _blogBloc.add(BlogGetAllBlogs());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(StringRes.blogPageTitle),
        centerTitle: true,
        leading: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthInitial) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoute.signInPage,
                (route) => false,
              );
            }
          },
          child: IconButton(
            onPressed: () {
              _authBloc.add(AuthSignOut());
            },
            icon: const Icon(Icons.logout_rounded),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRoute.addNewBlogPage);
            },
            icon: const Icon(CupertinoIcons.add_circled),
          ),
        ],
      ),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is BlogFailure) {
            AppUtils.showSnackBar(context, state.message);
          }
        },
        builder: (context, state) {
          if (state is BlogLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is BlogGetAllBlogsSuccess) {
            final blogs = state.blogEntities;
            return ListView.builder(
              padding: const EdgeInsets.symmetric(
                horizontal: SizeRes.pagePadding,
              ),
              itemCount: blogs.length,
              itemBuilder: (context, index) {
                final blog = blogs[index];
                return Padding(
                  padding: EdgeInsets.only(
                    top: index == 0 ? SizeRes.pagePadding : 0,
                    bottom: SizeRes.pagePadding,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        AppRoute.blogViewPage,
                        arguments: blog,
                      );
                    },
                    child: BlogCard(
                      blog: blog,
                      cardColor: index % 3 == 0
                          ? ColorRes.gradient1
                          : index % 3 == 1
                              ? ColorRes.gradient2
                              : ColorRes.gradient3,
                    ),
                  ),
                );
              },
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
