import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/image_cubit.dart';
import '../../../../core/res/color_res.dart';
import '../../../../core/res/size_res.dart';
import '../../../../core/res/string_res.dart';
import '../../../../core/res/style_res.dart';

class SelectImage extends StatefulWidget {
  const SelectImage({super.key});

  @override
  State<SelectImage> createState() => _SelectImageState();
}

class _SelectImageState extends State<SelectImage> {
  late final ImageCubit _imageCubit;
  @override
  void initState() {
    _imageCubit = context.read<ImageCubit>();
    super.initState();
  }

  @override
  void dispose() {
    _imageCubit.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _imageCubit.pickImage();
      },
      child: DottedBorder(
        color: ColorRes.border,
        dashPattern: const [10, 4],
        radius: const Radius.circular(
          SizeRes.selectImageBoxBorderRadius,
        ),
        borderType: BorderType.RRect,
        strokeCap: StrokeCap.round,
        child: BlocBuilder<ImageCubit, Uint8List?>(
          builder: (context, state) {
            return Container(
              height: SizeRes.selectImageBoxHeight,
              width: double.maxFinite,
              decoration: state != null
                  ? BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        SizeRes.selectImageBoxBorderRadius,
                      ),
                      image: DecorationImage(
                        image: MemoryImage(state),
                        fit: BoxFit.cover,
                      ),
                    )
                  : null,
              child: state == null
                  ? const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //
                        Icon(
                          Icons.folder_open_rounded,
                          size: SizeRes.selectImageBoxIconSize,
                        ),

                        SizedBox(height: SizeRes.gapSmall),

                        Text(
                          StringRes.selectImage,
                          style: StyleRes.bodyLarge,
                        ),
                      ],
                    )
                  : null,
            );
          },
        ),
      ),
    );
  }
}
