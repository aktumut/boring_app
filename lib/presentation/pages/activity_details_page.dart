import 'package:boring_app/data/models/activity_model.dart';
import 'package:boring_app/presentation/widgets/activity_details_page_widgets/activity_details_app_bar.dart';
import 'package:boring_app/presentation/widgets/activity_details_page_widgets/image_with_text.dart';
import 'package:boring_app/presentation/widgets/activity_details_page_widgets/information_widget_wrap.dart';
import 'package:boring_app/utils/constants.dart';
import 'package:boring_app/utils/text_style_theme.dart';
import 'package:boring_app/utils/theme.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class ActivityDetailsPage extends StatelessWidget {
  final ActivityModel activity;
  static const String id = 'activity_details_page';

  const ActivityDetailsPage({super.key, required this.activity});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ActivityDetailsAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            ImageWithText(activity: activity),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: tSpaceHorizontalPadding,
                  vertical: tSpaceVerticalPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildActivityInformationText(),
                  _buildExtraInformationText(),
                  InformationWidgetWrap(activity: activity),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _buildExtraInformationText() {
    return Container(
      padding: const EdgeInsets.only(bottom: tSpaceVerticalPadding),
      child: Text(
        tTextExtraInformation,
        style: tTextStyleHeader2.copyWith(color: tColorBlack),
      ),
    );
  }

  Container _buildActivityInformationText() {
    return Container(
      padding: const EdgeInsets.only(bottom: tSpaceVerticalPadding),
      child: Text(
        generateWordPairs().take(tNumberOfRandomWords).toList().join(' '),
        style: tTextStyleRegular,
      ),
    );
  }
}
