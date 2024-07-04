import 'package:boring_app/data/models/activity_model.dart';
import 'package:boring_app/utils/activity_type_images.dart';
import 'package:boring_app/utils/constants.dart';
import 'package:boring_app/utils/theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget({
    required this.activity,
    required this.isShadow,
    super.key,
  });

  final ActivityModel activity;
  final bool isShadow;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: activityTypeImages[activity.type] ??
          activityTypeImages[tTextNotFound]!,
      height: !isShadow ? tHeightActivityListTile : tHeightFilteredImage,
      width: double.infinity,
      fit: BoxFit.cover,
      imageBuilder:
          (BuildContext context, ImageProvider<Object> imageProvider) =>
              Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
            colorFilter: isShadow
                ? ColorFilter.mode(
                    tColorBlack.withOpacity(tOpacityImage),
                    BlendMode.darken,
                  )
                : null,
          ),
        ),
      ),
    );
  }
}
