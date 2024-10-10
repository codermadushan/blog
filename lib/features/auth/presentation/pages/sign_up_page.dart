import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/auth_bloc.dart';
import '../widgets/auth_field.dart';
import '../widgets/link_text.dart';
import '../widgets/main_button.dart';
import '../../../../core/utils/app_utils.dart';
import '../../../../core/res/size_res.dart';
import '../../../../core/res/string_res.dart';
import '../../../../core/res/style_res.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  late final AuthBloc _authBloc;

  @override
  void initState() {
    _authBloc = context.read<AuthBloc>();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: SizeRes.pagePadding,
        ),
        child: Form(
          key: _formKey,
          child: Center(
            child: SingleChildScrollView(
              reverse: true,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //
                  const SizedBox(height: SizeRes.gapMedium),

                  const Text(
                    '${StringRes.signUpLabel}.',
                    style: StyleRes.titleLarge,
                  ),

                  const SizedBox(height: SizeRes.gapLarge),

                  AuthField(
                    controller: _nameController,
                    hintText: StringRes.hintName,
                    validator: AppUtils.nameValidator,
                  ),

                  const SizedBox(height: SizeRes.gapSmall),

                  AuthField(
                    controller: _emailController,
                    hintText: StringRes.hintEmail,
                    validator: AppUtils.emailValidator,
                  ),

                  const SizedBox(height: SizeRes.gapSmall),

                  AuthField(
                    controller: _passwordController,
                    hintText: StringRes.hintPassword,
                    isPassword: true,
                    validator: AppUtils.passwordValidator,
                  ),

                  const SizedBox(height: SizeRes.gapMedium),

                  BlocSelector<AuthBloc, AuthState, bool>(
                    selector: (state) {
                      return state is AuthLoading;
                    },
                    builder: (context, isLoading) {
                      return MainButton(
                        label: StringRes.signUpLabel,
                        onTap: () {
                          final isValid = _formKey.currentState!.validate();
                          if (isValid) {
                            _authBloc.add(AuthSignUp(
                              name: _nameController.text.trim(),
                              email: _emailController.text.trim(),
                              password: _passwordController.text.trim(),
                            ));
                          }
                        },
                        isLoading: isLoading,
                      );
                    },
                  ),

                  const SizedBox(height: SizeRes.gapMedium),

                  LinkText(
                    text: StringRes.isThereAccount,
                    link: StringRes.signInLabel,
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),

                  const SizedBox(height: SizeRes.gapMedium),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
