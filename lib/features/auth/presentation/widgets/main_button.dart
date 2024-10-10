import 'package:flutter/material.dart';

import '../../../../core/res/color_res.dart';
import '../../../../core/res/size_res.dart';
import '../../../../core/res/style_res.dart';

class MainButton extends StatelessWidget {
  final String _label;
  final VoidCallback _onTap;
  final bool _isLoading;

  const MainButton({
    super.key,
    required String label,
    required VoidCallback onTap,
    bool isLoading = false,
  })  : _label = label,
        _onTap = onTap,
        _isLoading = isLoading;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            ColorRes.gradient1,
            ColorRes.gradient2,
          ],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
        borderRadius: BorderRadius.circular(SizeRes.mainButtonBorderRadius),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(SizeRes.mainButtonHeight),
          foregroundColor: ColorRes.white,
          backgroundColor: ColorRes.transparent,
          shadowColor: ColorRes.transparent,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(SizeRes.mainButtonBorderRadius),
          ),
        ),
        onPressed: _isLoading ? () {} : _onTap,
        child: _isLoading
            ? const SizedBox(
                width: SizeRes.mainButtonLoaderSize,
                height: SizeRes.mainButtonLoaderSize,
                child: CircularProgressIndicator(),
              )
            : Text(
                _label,
                style: StyleRes.btnLabel,
              ),
      ),
    );
  }
}
