import 'package:boring_app/business_logic/blocs/activity/activity_cubit.dart';
import 'package:boring_app/helpers/capitalize_first_letter.dart';
import 'package:boring_app/utils/activity_type_icons.dart';
import 'package:boring_app/utils/text_style_theme.dart';
import 'package:boring_app/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterIcon extends StatelessWidget {
  const FilterIcon({
    required this.activityType,
    required this.isSelected,
    super.key,
  });

  final String activityType;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<ActivityCubit>().filterActivities(activityType),
      child: Container(
        height: tHeightFilterWidget,
        width: tWidthFilterWidget,
        margin: const EdgeInsets.symmetric(horizontal: tSpaceHalf),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(tRadiusFilterWidget),
          border: Border.all(
            width: tWidthBorderFilterWidget,
            color: isSelected ? tColorWhite : tColorLightGray,
          ),
          color: isSelected ? tColorWhite : tColorPrimary,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              activityTypeIcons[activityType] ?? Icons.generating_tokens,
              color: isSelected ? tColorPrimary : tColorWhite,
              size: tSizeIconFilterWidget,
            ),
            const SizedBox(height: tSpaceHalf),
            Text(
              capitalizeFirstLetter(activityType),
              style: tTextStyleFilterWidgets.copyWith(
                color: isSelected ? tColorPrimary : tColorWhite,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
