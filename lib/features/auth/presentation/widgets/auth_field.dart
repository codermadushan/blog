import 'package:flutter/material.dart';

import '../../../../core/res/style_res.dart';

class AuthField extends StatelessWidget {
  final TextEditingController _controller;
  final String _hintText;
  final bool _isPassword;
  final String? Function(String?)? _validator;

  const AuthField({
    super.key,
    required TextEditingController controller,
    required String hintText,
    bool isPassword = false,
    String? Function(String?)? validator,
  })  : _controller = controller,
        _hintText = hintText,
        _isPassword = isPassword,
        _validator = validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      validator: _validator,
      obscureText: _isPassword,
      decoration: InputDecoration(
        hintText: _hintText,
        hintStyle: StyleRes.hintText,
      ),
    );
  }
}
