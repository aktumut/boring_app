import 'package:boring_app/data/models/activity_model.dart';
import 'package:boring_app/presentation/widgets/fav_icon.dart';
import 'package:boring_app/presentation/widgets/image_widget.dart';
import 'package:boring_app/utils/constants.dart';
import 'package:boring_app/utils/text_style_theme.dart';
import 'package:boring_app/utils/theme.dart';
import 'package:flutter/material.dart';

class ImageWithText extends StatelessWidget {
  const ImageWithText({
    super.key,
    required this.activity,
  });

  final ActivityModel activity;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            ImageWidget(activity: activity, isShadow: true),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: tSpaceDoubleHorizontalPadding,
              ),
              child: Text(
                activity.activity ?? tTextRandomActivity,
                style: tTextStyleHeader2,
                textAlign: TextAlign.center,
              ),
            ),
            FavIcon(activity: activity)
          ],
        )
      ],
    );
  }
}
