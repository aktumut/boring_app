import 'package:boring_app/business_logic/blocs/activity/activity_cubit.dart';
import 'package:boring_app/presentation/widgets/home_page_widgets/filter_icon.dart';
import 'package:boring_app/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExtendedFilterIconList extends StatelessWidget {
  const ExtendedFilterIconList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ActivityCubit, ActivityState>(
      builder: (BuildContext context, ActivityState state) {
        if (state is ActivityLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ActivityLoaded) {
          return _buildExtendedFilterList(
              state.activityTypes, state.selectedFilter, context);
        } else if (state is ActivityError) {
          return Center(child: Text(state.message));
        } else {
          return const Center(child: Text('Unknown State'));
        }
      },
    );
  }

  Widget _buildExtendedFilterList(List<String> activityTypes,
      String selectedFilter, BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: tSpaceBase),
      width: double.infinity,
      child: Center(
        child: Wrap(
          spacing: tSpaceBase,
          runSpacing: tSpaceBase,
          children: activityTypes.map((activityType) {
            final bool isSelected = selectedFilter == activityType;
            return FilterIcon(
                activityType: activityType, isSelected: isSelected);
          }).toList(),
        ),
      ),
    );
  }
}
