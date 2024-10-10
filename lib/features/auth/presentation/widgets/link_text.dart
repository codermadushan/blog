import 'package:flutter/material.dart';

import '../../../../core/res/style_res.dart';

class LinkText extends StatelessWidget {
  final String _text;
  final String _link;
  final VoidCallback _onTap;

  const LinkText({
    super.key,
    required String text,
    required String link,
    required VoidCallback onTap,
  })  : _text = text,
        _link = link,
        _onTap = onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('$_text '),
        GestureDetector(
          onTap: _onTap,
          child: Text(_link, style: StyleRes.link),
        ),
      ],
    );
  }
}
