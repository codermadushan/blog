import 'package:flutter/material.dart';

import '../../../../core/res/size_res.dart';

class UploadButton extends StatelessWidget {
  final VoidCallback _onTap;
  final bool _isLoading;

  const UploadButton({
    super.key,
    required VoidCallback onTap,
    bool isLoading = false,
  })  : _onTap = onTap,
        _isLoading = isLoading;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: _isLoading ? () {} : _onTap,
      icon: _isLoading
          ? const SizedBox(
              width: SizeRes.defaultIconSize,
              height: SizeRes.defaultIconSize,
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            )
          : const Icon(Icons.done_rounded),
    );
  }
}
