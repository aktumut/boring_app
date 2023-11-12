import 'package:boring_app/data/models/activity_model.dart';
import 'package:boring_app/helpers/get_color_based_on_info.dart';
import 'package:boring_app/presentation/widgets/activity_details_page_widgets/information_widget.dart';
import 'package:boring_app/utils/constants.dart';
import 'package:boring_app/utils/text_style_theme.dart';
import 'package:boring_app/utils/theme.dart';
import 'package:flutter/material.dart';

class InformationWidgetWrap extends StatelessWidget {
  final ActivityModel activity;

  const InformationWidgetWrap({super.key, required this.activity});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        spacing: tSpace,
        runSpacing: tSpace,
        children: [
          InformationWidget(
            informationIconText: tTextPrice,
            informationIconWidget: Icon(
              Icons.euro,
              size: tSizeActivityListTilePriceIcon,
              color: getColorBasedOnInfo(activity.price!),
            ),
          ),
          InformationWidget(
            informationIconText: tTextParticipants,
            informationIconWidget: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.person,
                  size: tSizeActivityListTilePriceIcon,
                  color: tColorYellow,
                ),
                const SizedBox(width: tSpaceHalf),
                Text(
                  activity.participants.toString(),
                  style: tTextStyleRegular2.copyWith(color: tColorWhite),
                ),
              ],
            ),
          ),
          InformationWidget(
            informationIconText: tTextAccessibility,
            informationIconWidget: Icon(
              Icons.people,
              size: tSizeActivityListTilePriceIcon,
              color: getColorBasedOnInfo(activity.accessibility!),
            ),
          ),
        ],
      ),
    );
  }
}
