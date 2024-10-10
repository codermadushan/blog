import 'package:flutter/foundation.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_utils.dart';

class ImageCubit extends Cubit<Uint8List?> {
  ImageCubit() : super(null);

  Future<void> pickImage() async {
    final image = await AppUtils.pickImage();
    if (image != null) {
      emit(image);
    }
  }

  void clear() {
    if (state != null) {
      emit(null);
    }
  }
}
