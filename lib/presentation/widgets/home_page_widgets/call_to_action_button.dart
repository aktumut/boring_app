import 'package:boring_app/business_logic/blocs/activity/activity_cubit.dart';
import 'package:boring_app/business_logic/blocs/appbar/app_bar_cubit.dart';
import 'package:boring_app/helpers/determine_app_bar_height.dart';
import 'package:boring_app/utils/constants.dart';
import 'package:boring_app/utils/text_style_theme.dart';
import 'package:boring_app/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CallToActionButton extends StatelessWidget {
  const CallToActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: tSpace,
      left: tSpaceDoubleHorizontalPadding,
      right: tSpaceDoubleHorizontalPadding,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shadowColor: tColorsTransparent,
          backgroundColor: tColorWhite,
          foregroundColor: tColorPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(tRadiusButton),
          ),
        ),
        onPressed: () {
          _handleButtonPress(context);
        },
        child: const Text(
          tTextCallToAction,
          style: tTextStyleRegular2,
        ),
      ),
    );
  }

  void _handleButtonPress(BuildContext context) {
    final appBarHeight = determineAppBarHeight(
      context.read<ActivityCubit>().activityTypes.length,
    );
    context.read<AppBarCubit>().expandAppBarWithAllFilters(appBarHeight);
  }
}
