import 'package:flutter/material.dart';

import '../../../../core/res/style_res.dart';

class BlogEditor extends StatelessWidget {
  final TextEditingController _controller;
  final String _hintText;
  final String? Function(String?)? _validator;

  const BlogEditor({
    super.key,
    required TextEditingController controller,
    required String hintText,
    String? Function(String?)? validator,
  })  : _controller = controller,
        _hintText = hintText,
        _validator = validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      validator: _validator,
      decoration: InputDecoration(
        hintText: _hintText,
        hintStyle: StyleRes.hintText,
      ),
      maxLines: null,
    );
  }
}
