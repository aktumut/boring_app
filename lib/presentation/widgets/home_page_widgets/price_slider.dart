import 'package:boring_app/business_logic/blocs/activity/activity_cubit.dart';
import 'package:boring_app/utils/constants.dart';
import 'package:boring_app/utils/text_style_theme.dart';
import 'package:boring_app/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PriceSlider extends StatelessWidget {
  final ActivityLoaded state;

  const PriceSlider({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: tHeightSliderParticipantField,
            padding: const EdgeInsets.symmetric(horizontal: tSpaceDouble),
            child: const Text(
              tTextPrice,
              style: tTextStyleFilterWidgets,
            ),
          ),
          Container(
            height: tHeightSliderParticipantField,
            padding: const EdgeInsets.symmetric(horizontal: tSpaceHalf),
            child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                valueIndicatorColor: tColorWhite,
                valueIndicatorTextStyle: tTextStyleActivityListTileHeader,
              ),
              child: Slider(
                thumbColor: tColorWhite,
                activeColor: tColorWhite,
                inactiveColor: tColorGray,
                divisions: tDivSlider,
                min: tMinSlider,
                max: tMaxSlider,
                value: state.currentSliderValue,
                label: state.currentSliderValue.round().toString(),
                onChanged: (value) {
                  context.read<ActivityCubit>().updateSliderValue(value);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
