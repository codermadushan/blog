import 'package:flutter/material.dart';

import '../../domain/entities/blog_entity.dart';
import '../../../../core/utils/app_utils.dart';
import '../../../../core/res/style_res.dart';
import '../../../../core/res/size_res.dart';

class BlogCard extends StatelessWidget {
  final BlogEntity _blog;
  final Color _cardColor;

  const BlogCard({
    super.key,
    required BlogEntity blog,
    required Color cardColor,
  })  : _blog = blog,
        _cardColor = cardColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: SizeRes.pagePadding),
      height: SizeRes.blogCardHeight,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: BorderRadius.circular(SizeRes.blogCardBorderRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                _blog.topics.length,
                (index) {
                  final chipLabel = _blog.topics[index];
                  return Padding(
                    padding: EdgeInsets.only(
                      right: SizeRes.gapSmall,
                      left: index == 0 ? SizeRes.gapSmall : 0,
                    ),
                    child: Chip(
                      label: Text(chipLabel),
                      side: BorderSide.none,
                    ),
                  );
                },
              ),
            ),
          ),

          // Title
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: SizeRes.pagePadding,
            ),
            child: Text(
              _blog.title,
              style: StyleRes.blogCardTitle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          const Spacer(),

          // Reading time
          Padding(
            padding: const EdgeInsets.only(left: SizeRes.pagePadding),
            child: Text(
              '${AppUtils.calculateReadingTime(_blog.content)} min',
            ),
          ),
        ],
      ),
    );
  }
}
