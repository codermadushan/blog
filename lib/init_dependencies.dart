import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/secret/app_secret.dart';
import 'core/common/cubits/app_user/app_user_cubit.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/data/sources/auth_remote_source.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/domain/usecases/get_current_user.dart';
import 'features/auth/domain/usecases/sign_in.dart';
import 'features/auth/domain/usecases/sign_out.dart';
import 'features/auth/domain/usecases/sign_up.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/blog/data/repositories/blog_repository_impl.dart';
import 'features/blog/data/sources/blog_remote_source.dart';
import 'features/blog/domain/repositories/blog_repository.dart';
import 'features/blog/domain/usecases/get_all_blogs.dart';
import 'features/blog/domain/usecases/upload_blog.dart';
import 'features/blog/presentation/bloc/blog_bloc.dart';
import 'features/blog/presentation/cubits/image_cubit.dart';
import 'features/blog/presentation/cubits/selected_labels_cubit.dart';

final sl = GetIt.instance;

void _initCommon() {
  sl.registerLazySingleton<SupabaseClient>(
    () => Supabase.instance.client,
  );
}

void _initAuth() {
  sl.registerFactory<AuthRemoteSource>(
    () => AuthRemoteSourceImpl(sl()),
  );

  sl.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(sl()),
  );

  // Usecases
  sl.registerFactory<SignUp>(
    () => SignUp(sl()),
  );

  sl.registerFactory<SignIn>(
    () => SignIn(sl()),
  );

  sl.registerLazySingleton<AppUserCubit>(
    () => AppUserCubit(),
  );

  sl.registerFactory<GetCurrentUser>(
    () => GetCurrentUser(sl()),
  );

  sl.registerFactory<SignOut>(
    () => SignOut(sl()),
  );

  // Bloc
  sl.registerLazySingleton<AuthBloc>(
    () => AuthBloc(
      signUp: sl(),
      signIn: sl(),
      appUserCubit: sl(),
      getCurrentUser: sl(),
      signOut: sl(),
    ),
  );
}

void _initBlog() {
  sl.registerLazySingleton<ImageCubit>(
    () => ImageCubit(),
  );

  sl.registerLazySingleton<SelectedLabelsCubit>(
    () => SelectedLabelsCubit(),
  );

  sl.registerFactory<BlogRemoteSource>(
    () => BlogRemoteSourceImpl(sl()),
  );

  sl.registerFactory<BlogRepository>(
    () => BlogRepositoryImpl(
      blogRemoteSourceImpl: sl(),
    ),
  );

  sl.registerFactory<UploadBlog>(
    () => UploadBlog(sl()),
  );

  sl.registerFactory<GetAllBlogs>(
    () => GetAllBlogs(sl()),
  );

  sl.registerLazySingleton<BlogBloc>(
    () => BlogBloc(
      uploadBlog: sl(),
      getAllBlogs: sl(),
    ),
  );
}

Future<void> initDependencies() async {
  await Supabase.initialize(
    url: AppSecret.supabaseUrl,
    anonKey: AppSecret.supabaseAnonKey,
  );
  _initCommon();
  _initAuth();
  _initBlog();
}
