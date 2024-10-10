import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/selected_labels_cubit.dart';
import '../../../../core/res/color_res.dart';
import '../../../../core/res/size_res.dart';
import '../../../../core/res/string_res.dart';

class ChipRaw extends StatefulWidget {
  const ChipRaw({super.key});

  @override
  State<ChipRaw> createState() => _ChipRawState();
}

class _ChipRawState extends State<ChipRaw> {
  late final SelectedLabelsCubit _selectedLabelsCubit;
  final _labels = const [
    StringRes.chipBusiness,
    StringRes.chipEntertainment,
    StringRes.chipProgramming,
    StringRes.chipTechnology,
  ];

  @override
  void initState() {
    _selectedLabelsCubit = context.read<SelectedLabelsCubit>();
    super.initState();
  }

  @override
  void dispose() {
    _selectedLabelsCubit.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: BlocBuilder<SelectedLabelsCubit, List<String>>(
        builder: (context, state) {
          return Row(
            children: List.generate(
              SizeRes.blogChipCount,
              (index) {
                return Padding(
                  padding: EdgeInsets.only(
                    left: index == 0 ? SizeRes.pagePadding : 0,
                    right: SizeRes.pagePadding,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      final label = _labels[index];
                      if (state.contains(label)) {
                        _selectedLabelsCubit.removeLabel(label);
                      } else {
                        _selectedLabelsCubit.addLabel(label);
                      }
                    },
                    child: Chip(
                      label: Text(_labels[index]),
                      backgroundColor: state.contains(_labels[index])
                          ? ColorRes.gradient1
                          : null,
                      side: state.contains(_labels[index])
                          ? const BorderSide(color: ColorRes.transparent)
                          : null,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
