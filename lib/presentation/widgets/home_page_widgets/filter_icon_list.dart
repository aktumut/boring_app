import 'package:boring_app/business_logic/blocs/activity/activity_cubit.dart';
import 'package:boring_app/presentation/widgets/home_page_widgets/filter_icon.dart';
import 'package:boring_app/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterIconList extends StatelessWidget {
  const FilterIconList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ActivityCubit, ActivityState>(
      builder: (BuildContext context, ActivityState state) {
        if (state is ActivityLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ActivityLoaded) {
          return _buildFilterList(
            state.activityTypes,
            state.selectedFilter,
            context,
          );
        } else if (state is ActivityError) {
          return Center(child: Text(state.message));
        } else {
          return const Center(child: Text('Restart Your App'));
        }
      },
    );
  }

  Widget _buildFilterList(
    List<String> activityTypes,
    String selectedFilter,
    BuildContext context,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: tSpaceBase),
      height: tHeightFilterWidget,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: activityTypes.length,
        itemBuilder: (BuildContext context, int index) {
          final activityType = activityTypes[index];
          final isSelected = selectedFilter == activityType;
          return FilterIcon(activityType: activityType, isSelected: isSelected);
        },
      ),
    );
  }
}
