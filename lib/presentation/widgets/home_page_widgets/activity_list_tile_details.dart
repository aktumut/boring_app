import 'package:boring_app/data/models/activity_model.dart';
import 'package:boring_app/helpers/capitalize_first_letter.dart';
import 'package:boring_app/helpers/format_accessibility.dart';
import 'package:boring_app/helpers/format_activity_text.dart';
import 'package:boring_app/helpers/format_price.dart';
import 'package:boring_app/helpers/get_color_based_on_info.dart';
import 'package:boring_app/utils/constants.dart';
import 'package:boring_app/utils/text_style_theme.dart';
import 'package:boring_app/utils/theme.dart';
import 'package:flutter/material.dart';

class ActivityListTileDetails extends StatelessWidget {
  const ActivityListTileDetails({
    required this.activity,
    super.key,
  });

  final ActivityModel activity;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: tSpaceHalfHorizontalPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildActivityDescription(),
          _buildActivityPricing(),
        ],
      ),
    );
  }

  Widget _buildActivityDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: tSpaceBase),
        Text(
          capitalizeFirstLetter(activity.type ?? tTextRandomActivity),
          style: tTextStyleActivityListTileHeader,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: tSpaceQuarter),
          child: _buildAccessibilityAndParticipants(),
        ),
        const SizedBox(height: tSpaceHalf),
        Text(
          formatActivityText(activity.activity ?? tTextRandomActivity),
          style: tTextStyleActivityListTileActivity,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        const SizedBox(height: tSpaceDouble),
      ],
    );
  }

  Widget _buildAccessibilityAndParticipants() {
    return Row(
      children: [
        const Icon(
          Icons.person,
          size: tSizeActivityListTileIcon,
          color: tColorDarkGray,
        ),
        Text(
          '${activity.participants} | $tTextAccessibility: ${formatAccessibility(activity.accessibility!)}/10',
          style: tTextStyleActivityListTileSubHeader,
        ),
      ],
    );
  }

  Widget _buildActivityPricing() {
    return Column(
      children: [
        Icon(
          Icons.euro,
          size: tSizeActivityListTilePriceIcon,
          color: getColorBasedOnInfo(activity.price!),
        ),
        const SizedBox(height: tSpaceHalf),
        Text(
          formatPriceText(activity.price!),
          style: tTextStyleActivityListTileHeader,
        ),
      ],
    );
  }
}
