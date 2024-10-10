import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/auth_bloc.dart';
import '../widgets/auth_field.dart';
import '../widgets/link_text.dart';
import '../widgets/main_button.dart';
import '../../../../core/route/app_route.dart';
import '../../../../core/utils/app_utils.dart';
import '../../../../core/res/size_res.dart';
import '../../../../core/res/string_res.dart';
import '../../../../core/res/style_res.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
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
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: SizeRes.pagePadding,
        ),
        child: Form(
          key: _formKey,
          child: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                reverse: true,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //
                    const SizedBox(height: SizeRes.gapMedium),

                    const Text(
                      '${StringRes.signInLabel}.',
                      style: StyleRes.titleLarge,
                    ),

                    const SizedBox(height: SizeRes.gapLarge),

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

                    BlocConsumer<AuthBloc, AuthState>(
                      listener: (context, state) {
                        if (state is AuthFailure) {
                          AppUtils.showSnackBar(context, state.message);
                        } else if (state is AuthSuccess) {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            AppRoute.blogPage,
                            (route) => false,
                          );
                        }
                      },
                      buildWhen: (previous, current) {
                        final isStateChanged = current != previous;
                        final isItAuthLoading =
                            previous is AuthLoading || current is AuthLoading;
                        return isStateChanged && isItAuthLoading;
                      },
                      builder: (context, state) {
                        final isLoading = state is AuthLoading;
                        return MainButton(
                          label: StringRes.signInLabel,
                          onTap: () {
                            final isValid = _formKey.currentState!.validate();
                            if (isValid) {
                              _authBloc.add(AuthSignIn(
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
                      text: StringRes.isntThereAccount,
                      link: StringRes.signUpLabel,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          AppRoute.signUpPage,
                        );
                      },
                    ),

                    const SizedBox(height: SizeRes.gapMedium),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
