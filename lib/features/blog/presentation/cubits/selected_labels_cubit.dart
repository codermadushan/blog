import 'package:flutter_bloc/flutter_bloc.dart';

class SelectedLabelsCubit extends Cubit<List<String>> {
  SelectedLabelsCubit() : super([]);

  void addLabel(String label) {
    emit(List.from(state)..add(label));
  }

  void removeLabel(String label) {
    emit(List.from(state)..remove(label));
  }

  void clear() {
    if (state.isNotEmpty) {
      emit([]);
    }
  }
}
