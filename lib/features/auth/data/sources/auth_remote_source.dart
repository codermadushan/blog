import 'package:flutter/foundation.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/user_model.dart';
import '../../../../core/res/supabase_res.dart';
import '../../../../core/res/string_res.dart';
import '../../../../core/error/server_exception.dart';

@immutable
abstract interface class AuthRemoteSource {
  Future<UserModel> signUp({
    required String name,
    required String email,
    required String password,
  });

  Future<UserModel> signIn({
    required String email,
    required String password,
  });

  Future<UserModel> getCurrentUser();

  Future<void> signOut();
}

@immutable
class AuthRemoteSourceImpl implements AuthRemoteSource {
  final SupabaseClient _supabaseClient;

  const AuthRemoteSourceImpl(SupabaseClient supabaseClient)
      : _supabaseClient = supabaseClient;

  @override
  Future<UserModel> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final authResponse = await _supabaseClient.auth.signUp(
        email: email,
        password: password,
        data: {SupabaseRes.name: name},
      );
      final user = authResponse.user;
      if (user == null) {
        throw const ServerException(StringRes.nullUser);
      }
      final userModel = UserModel(
        userId: user.id,
        name: name,
        email: email,
      );
      return userModel;
    } on AuthException catch (e) {
      throw ServerException(e.message);
    } on ServerException catch (e) {
      throw ServerException('$e');
    } catch (e) {
      throw const ServerException(StringRes.defaultError);
    }
  }

  @override
  Future<UserModel> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final authResponse = await _supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );
      final user = authResponse.user;
      if (user == null) {
        throw const ServerException(StringRes.nullUser);
      }
      final userModel = UserModel(
        userId: user.id,
        name: user.userMetadata![SupabaseRes.name],
        email: email,
      );
      return userModel;
    } on AuthException catch (e) {
      throw ServerException(e.message);
    } on ServerException catch (e) {
      throw ServerException('$e');
    } catch (e) {
      throw const ServerException(StringRes.defaultError);
    }
  }

  @override
  Future<UserModel> getCurrentUser() async {
    try {
      final currentSession = _supabaseClient.auth.currentSession;
      if (currentSession == null) {
        throw const ServerException(StringRes.nullUser);
      }
      final user = currentSession.user;
      final userModel = UserModel(
        userId: user.id,
        name: user.userMetadata![SupabaseRes.name],
        email: user.email!,
      );
      return userModel;
    } on ServerException catch (e) {
      throw ServerException('$e');
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _supabaseClient.auth.signOut();
    } catch (e) {
      ServerException('$e');
    }
  }
}
