import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'init_dependencies.dart';
import 'core/route/app_route.dart';
import 'core/theme/app_theme.dart';
import 'core/common/cubits/app_user/app_user_cubit.dart';
import 'features/blog/presentation/bloc/blog_bloc.dart';
import 'features/blog/presentation/cubits/selected_labels_cubit.dart';
import 'features/blog/presentation/cubits/image_cubit.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<AuthBloc>()),
        BlocProvider(create: (context) => sl<AppUserCubit>()),
        BlocProvider(create: (context) => sl<ImageCubit>()),
        BlocProvider(create: (context) => sl<SelectedLabelsCubit>()),
        BlocProvider(create: (context) => sl<BlogBloc>()),
      ],
      child: const Blog(),
    ),
  );
}

class Blog extends StatefulWidget {
  const Blog({super.key});

  @override
  State<Blog> createState() => _BlogState();
}

class _BlogState extends State<Blog> {
  @override
  void initState() {
    final authBloc = context.read<AuthBloc>();
    authBloc.add(AuthGetCurrentUser());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AuthBloc, AuthState, bool>(
      selector: (state) {
        return state is AuthSuccess;
      },
      builder: (context, isLoggedIn) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.dark,
          initialRoute: isLoggedIn ? AppRoute.blogPage : AppRoute.signInPage,
          routes: AppRoute.routes,
        );
      },
    );
  }
}
