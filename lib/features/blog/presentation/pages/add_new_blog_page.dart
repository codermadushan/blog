import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/blog_bloc.dart';
import '../cubits/image_cubit.dart';
import '../cubits/selected_labels_cubit.dart';
import '../widgets/blog_editor.dart';
import '../widgets/chip_row.dart';
import '../widgets/select_image.dart';
import '../widgets/upload_button.dart';
import '../../../../core/utils/app_utils.dart';
import '../../../../core/res/string_res.dart';
import '../../../../core/res/size_res.dart';
import '../../../../core/common/cubits/app_user/app_user_cubit.dart';

class AddNewBlogPage extends StatefulWidget {
  const AddNewBlogPage({super.key});

  @override
  State<AddNewBlogPage> createState() => _AddNewBlogPageState();
}

class _AddNewBlogPageState extends State<AddNewBlogPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  // Blocs & Cubits
  late final BlogBloc _blogBloc;
  late final ImageCubit _imageCubit;
  late final AppUserCubit _appUserCubit;
  late final SelectedLabelsCubit _selectedLabelsCubit;

  void _uploadBlog() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) return;
    _blogBloc = context.read<BlogBloc>();
    _imageCubit = context.read<ImageCubit>();
    _appUserCubit = context.read<AppUserCubit>();
    _selectedLabelsCubit = context.read<SelectedLabelsCubit>();
    _blogBloc.add(BlogUploadBlog(
      posterId: (_appUserCubit.state as AppUserLoggedIn).user.userId,
      title: _titleController.text.trim(),
      content: _contentController.text.trim(),
      topics: _selectedLabelsCubit.state,
      image: _imageCubit.state,
    ));
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          BlocConsumer<BlogBloc, BlogState>(
            listener: (context, state) {
              if (state is BlogFailure) {
                AppUtils.showSnackBar(context, state.message);
              } else if (state is BlogUploadSuccess) {
                Navigator.pop(context);
              }
            },
            buildWhen: (previous, current) {
              final isStateChanged = previous != current;
              final isItBlogLoading =
                  previous is BlogLoading || current is BlogLoading;
              return isStateChanged && isItBlogLoading;
            },
            builder: (context, state) {
              final isLoading = state is BlogLoading;
              return UploadButton(
                onTap: _uploadBlog,
                isLoading: isLoading,
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              //
              const SizedBox(height: SizeRes.gapMedium),

              const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeRes.pagePadding,
                ),
                child: SelectImage(),
              ),

              const SizedBox(height: SizeRes.gapMedium),

              const ChipRaw(),

              const SizedBox(height: SizeRes.gapMedium),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: SizeRes.pagePadding,
                ),
                child: BlogEditor(
                  controller: _titleController,
                  hintText: StringRes.hintBlogTitle,
                  validator: AppUtils.blogTitleValidator,
                ),
              ),

              const SizedBox(height: SizeRes.gapMedium),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: SizeRes.pagePadding,
                ),
                child: BlogEditor(
                  controller: _contentController,
                  hintText: StringRes.hintBlogContent,
                  validator: AppUtils.blogContentValidator,
                ),
              ),

              const SizedBox(height: SizeRes.gapMedium),
            ],
          ),
        ),
      ),
    );
  }
}
