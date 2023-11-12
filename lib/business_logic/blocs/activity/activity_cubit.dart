import 'dart:math' as math;

import 'package:boring_app/business_logic/blocs/activity_like/activity_like_cubit.dart';
import 'package:boring_app/business_logic/repositories/activity_repository.dart';
import 'package:boring_app/data/models/activity_model.dart';
import 'package:boring_app/utils/constants.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'activity_state.dart';

class ActivityCubit extends Cubit<ActivityState> {
  final ScrollController activityListScrollController;
  final ActivityRepository _activityRepository;
  final List<ActivityModel> _allActivities = [];
  List<String> activityTypes = [];
  Set<String> activityTypesSet = {tTextFilterAll};
  double currentSliderValue = 1;

  ActivityCubit(this._activityRepository, this.activityListScrollController)
      : super(ActivityLoading()) {
    activityListScrollController.addListener(_fetchMoreActivities);
  }

  Future<void> fetchActivities() async {
    try {
      await _fetchAndProcessActivities(activityTypesSet);

      await _updateActivityLikes();
      activityTypes = activityTypesSet.toList();

      emit(ActivityLoaded(
          _allActivities, activityTypes, tTextFilterAll, currentSliderValue));
    } catch (exception) {
      emit(ActivityError(exception.toString()));
    }
  }

  Future<void> _fetchAndProcessActivities(Set<String> activityTypesSet) async {
    for (int i = 0; i < tNumberOfActivities; i++) {
      ActivityModel activity = await _activityRepository.fetchActivity();
      activity.likes = math.Random().nextInt(tMaxLikes);
      _allActivities.add(activity);
      activityTypesSet.add(activity.type!);
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
      emit(ActivityLoaded(filteredActivities, currentState.activityTypes,
          selectedType, currentSliderValue));
    }
  }

  void _fetchMoreActivities() {
    if (activityListScrollController.position.pixels ==
        activityListScrollController.position.maxScrollExtent) {
      fetchActivities();
    }
  }

  void filterActivitiesByPrice(double price) {
    List<ActivityModel> filteredActivities;

    if (state is ActivityLoaded) {
      ActivityLoaded currentState = state as ActivityLoaded;
      if (currentState.selectedFilter != tTextFilterAll) {
        filteredActivities = _allActivities
            .where((ActivityModel activity) =>
                activity.type == currentState.selectedFilter &&
                activity.price != null &&
                activity.price! * 10 <= price)
            .toList();
      } else {
        filteredActivities = _allActivities
            .where((ActivityModel activity) =>
                activity.price != null && (activity.price! * 10) <= price)
            .toList();
      }

      emit(ActivityLoaded(filteredActivities, currentState.activityTypes,
          currentState.selectedFilter, price));
    }
  }

  void updateSliderValue(double value) {
    if (state is ActivityLoaded) {
      currentSliderValue = value;
      filterActivitiesByPrice(currentSliderValue);
    }
  }

  void filterActivitiesByParticipants(int participantCount) {
    List<ActivityModel> filteredActivities;

    if (state is ActivityLoaded) {
      ActivityLoaded currentState = state as ActivityLoaded;
      if (currentState.selectedFilter != tTextFilterAll) {
        filteredActivities = _allActivities
            .where((ActivityModel activity) =>
                activity.type == currentState.selectedFilter &&
                activity.participants != null &&
                activity.participants! == participantCount)
            .toList();
      } else {
        filteredActivities = _allActivities
            .where((ActivityModel activity) =>
                activity.participants != null &&
                (activity.participants!) == participantCount)
            .toList();
      }

      emit(ActivityLoaded(filteredActivities, currentState.activityTypes,
          currentState.selectedFilter, currentState.currentSliderValue));
    }
  }
}
