import 'dart:math' as math;

import 'package:boring_app/business_logic/blocs/activity_like/activity_like_cubit.dart';
import 'package:boring_app/business_logic/repositories/activity_repository.dart';
import 'package:boring_app/data/models/activity_model.dart';
import 'package:boring_app/utils/constants.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'activity_state.dart';

class ActivityCubit extends Cubit<ActivityState> {
  final ActivityRepository _activityRepository;
  final List<ActivityModel> _allActivities = [];
  List<String> activityTypes = [];

  ActivityCubit(this._activityRepository) : super(ActivityLoading());

  Future<void> fetchActivities() async {
    try {
      Set<String> activityTypesSet = {tTextFilterAll};
      _allActivities.clear();

      for (int i = 0; i < tNumberOfActivities; i++) {
        ActivityModel activity = await _activityRepository.fetchActivity();
        activity.likes = math.Random().nextInt(tMaxLikes);
        _allActivities.add(activity);
        activityTypesSet.add(activity.type!);
      }

      await _updateActivityLikes();
      activityTypes = activityTypesSet.toList();

      emit(ActivityLoaded(_allActivities, activityTypes, tTextFilterAll));
    } catch (exception) {
      emit(ActivityError(exception.toString()));
    }
  }

  Future<void> _updateActivityLikes() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    for (var activity in _allActivities) {
      activity.isLiked = prefs.getBool(activity.key!) ?? false;
    }
  }

  void filterActivities(String selectedType) {
    List<ActivityModel> filteredActivities = selectedType == tTextFilterAll
        ? _allActivities
        : _allActivities
            .where((activity) => activity.type == selectedType)
            .toList();

    if (state is ActivityLoaded || state is ActivityLikeUpdate) {
      ActivityLoaded currentState = state as ActivityLoaded;
      emit(ActivityLoaded(
          filteredActivities, currentState.activityTypes, selectedType));
    }
  }
}
