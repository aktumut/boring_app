import 'package:boring_app/business_logic/blocs/activity/activity_cubit.dart';
import 'package:boring_app/data/models/activity_model.dart';
import 'package:boring_app/presentation/widgets/home_page_widgets/activity_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActivityList extends StatelessWidget {
  const ActivityList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ActivityCubit, ActivityState>(
      builder: (context, state) {
        if (state is ActivityLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ActivityLoaded) {
          return Column(
            children: state.activities
                .map(
                  (ActivityModel activity) =>
                      ActivityListTile(activity: activity),
                )
                .toList(),
          );
        } else if (state is ActivityError) {
          return Center(child: Text(state.message));
        } else {
          return const Center(child: Text('Unknown State'));
        }
      },
    );
  }
}
