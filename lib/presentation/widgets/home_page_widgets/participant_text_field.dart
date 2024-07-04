import 'package:boring_app/business_logic/blocs/activity/activity_cubit.dart';
import 'package:boring_app/utils/constants.dart';
import 'package:boring_app/utils/text_style_theme.dart';
import 'package:boring_app/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ParticipantTextField extends StatelessWidget {
  const ParticipantTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(tTextParticipants, style: tTextStyleFilterWidgets),
          Expanded(
            child: TextField(
              keyboardType: TextInputType.number,
              onSubmitted: (value) {
                final participantCount = int.tryParse(value);

                if (participantCount != null) {
                  context
                      .read<ActivityCubit>()
                      .filterActivitiesByParticipants(participantCount);
                }
              },
              style: tTextStyleHeader2,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(tSpaceHalf),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: tColorLightGray),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: tColorWhite, width: tSpaceQuarter),
                ),
                focusedErrorBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: tColorRed, width: tSpaceQuarter),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
