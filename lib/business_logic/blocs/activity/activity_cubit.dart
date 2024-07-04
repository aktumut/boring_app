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
  ActivityCubit(this._activityRepository, this.scrollController)
      : super(ActivityLoading()) {
    scrollController.addListener(_fetchMoreActivities);
  }

  final ScrollController scrollController;

  final ActivityRepository _activityRepository;

  final List<ActivityModel> _allActivities = [];

  List<String> activityTypes = [];

  Set<String> activityTypesSet = {tTextFilterAll};

  double currentSliderValue = 1;

  Future<void> fetchActivities() async {
    try {
      await _fetchAndProcessActivities(activityTypesSet);

      await _updateActivityLikes();
      activityTypes = activityTypesSet.toList();

      emit(
        ActivityLoaded(
          _allActivities,
          activityTypes,
          tTextFilterAll,
          currentSliderValue,
        ),
      );
    } catch (exception) {
      emit(ActivityError(exception.toString()));
    }
  }

  Future<void> _fetchAndProcessActivities(Set<String> activityTypesSet) async {
    for (var i = 0; i < tNumberOfActivities; i++) {
      final activity = await _activityRepository.fetchActivity();
      final updatedActivity = activity.copyWith(
        likes: math.Random().nextInt(tMaxLikes),
      );
      _allActivities.add(updatedActivity);
      activityTypesSet.add(updatedActivity.type!);
    }
  }

  Future<void> _updateActivityLikes() async {
    final prefs = await SharedPreferences.getInstance();
    for (var i = 0; i < _allActivities.length; i++) {
      final activity = _allActivities[i];
      final updatedActivity = activity.copyWith(
        isLiked: prefs.getBool(activity.key!) ?? false,
        likes: prefs.getInt('${activity.key!}_likes') ?? 0,
      );
      _allActivities[i] = updatedActivity;
    }
  }

  // Future<void> _updateActivityLikes() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   for (final activity in _allActivities) {
  //     activity.isLiked = prefs.getBool(activity.key!) ?? false;
  //   }
  // }

  void filterActivities(String selectedType) {
    final filteredActivities = selectedType == tTextFilterAll
        ? _allActivities
        : _allActivities
            .where((ActivityModel activity) => activity.type == selectedType)
            .toList();

    if (state is ActivityLoaded || state is ActivityLikeUpdate) {
      final currentState = state as ActivityLoaded;
      emit(
        ActivityLoaded(
          filteredActivities,
          currentState.activityTypes,
          selectedType,
          currentSliderValue,
        ),
      );
    }
  }

  void _fetchMoreActivities() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      fetchActivities();
    }
  }

  void filterActivitiesByPrice(double price) {
    List<ActivityModel> filteredActivities;

    if (state is ActivityLoaded) {
      final currentState = state as ActivityLoaded;
      if (currentState.selectedFilter != tTextFilterAll) {
        filteredActivities = _allActivities
            .where(
              (ActivityModel activity) =>
                  activity.type == currentState.selectedFilter &&
                  activity.price != null &&
                  activity.price! * 10 <= price,
            )
            .toList();
      } else {
        filteredActivities = _allActivities
            .where(
              (ActivityModel activity) =>
                  activity.price != null && (activity.price! * 10) <= price,
            )
            .toList();
      }

      emit(
        ActivityLoaded(
          filteredActivities,
          currentState.activityTypes,
          currentState.selectedFilter,
          price,
        ),
      );
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
      final currentState = state as ActivityLoaded;
      if (currentState.selectedFilter != tTextFilterAll) {
        filteredActivities = _allActivities
            .where(
              (ActivityModel activity) =>
                  activity.type == currentState.selectedFilter &&
                  activity.participants != null &&
                  activity.participants! == participantCount,
            )
            .toList();
      } else {
        filteredActivities = _allActivities
            .where(
              (ActivityModel activity) =>
                  activity.participants != null &&
                  (activity.participants!) == participantCount,
            )
            .toList();
      }

      emit(
        ActivityLoaded(
          filteredActivities,
          currentState.activityTypes,
          currentState.selectedFilter,
          currentState.currentSliderValue,
        ),
      );
    }
  }
}
