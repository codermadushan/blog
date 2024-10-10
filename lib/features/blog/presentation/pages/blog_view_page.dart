import 'package:flutter/material.dart';

import '../../domain/entities/blog_entity.dart';
import '../../../../core/res/media_res.dart';
import '../../../../core/utils/app_utils.dart';
import '../../../../core/res/size_res.dart';
import '../../../../core/res/style_res.dart';

class BlogViewPage extends StatefulWidget {
  const BlogViewPage({super.key});

  @override
  State<BlogViewPage> createState() => _BlogViewPageState();
}

class _BlogViewPageState extends State<BlogViewPage> {
  late final BlogEntity _blog;

  @override
  void didChangeDependencies() {
    final arg = ModalRoute.of(context)!.settings.arguments!;
    _blog = arg as BlogEntity;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final createdDate = AppUtils.dateFormatter(_blog.updatedAt);
    final readingTime = AppUtils.calculateReadingTime(_blog.content);

    return Scaffold(
      appBar: AppBar(),
      body: Scrollbar(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: SizeRes.pagePadding,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //
                Text(
                  _blog.title,
                  style: StyleRes.blogViewTitle,
                ),

                const SizedBox(height: SizeRes.gapMedium),

                Text(
                  'By ${_blog.posterName}',
                  style: StyleRes.blogViewPoster,
                ),

                const SizedBox(height: SizeRes.gapSmall),

                Text(
                  '$createdDate . $readingTime min',
                  style: StyleRes.blogViewDate,
                ),

                const SizedBox(height: SizeRes.gapMedium),

                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      SizeRes.blogCardBorderRadius,
                    ),
                    child: Image.network(
                      _blog.imageUrl ?? MediaRes.blogImagePlaceHolderUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          MediaRes.imagePlaceHolder,
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                ),

                const SizedBox(height: SizeRes.gapMedium),

                Text(
                  _blog.content,
                  style: StyleRes.bodyLarge,
                ),

                const SizedBox(height: SizeRes.gapMedium),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
