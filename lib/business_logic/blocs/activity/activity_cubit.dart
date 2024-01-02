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

/// Manages the state of activities in the application.
class ActivityCubit extends Cubit<ActivityState> {
  /// Creates an instance of `ActivityCubit` with a given [ActivityRepository].
  ///
  /// The [scrollController] is used to listen for scroll events to fetch more.
  ActivityCubit(this._activityRepository, this.scrollController)
      : super(ActivityLoading()) {
    scrollController.addListener(_fetchMoreActivities);
  }

  /// Controls the scroll position for activities.
  final ScrollController scrollController;

  /// Repository for fetching activity data.
  final ActivityRepository _activityRepository;

  /// A cache of all fetched activities.
  final List<ActivityModel> _allActivities = [];

  /// List of activity types available for filtering.
  List<String> activityTypes = [];

  /// A set of activity types used for filtering, initialized with 'All'.
  Set<String> activityTypesSet = {tTextFilterAll};

  /// The current value of the price filter slider.
  double currentSliderValue = 1;

  /// Fetches activities and handles the state accordingly.
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
      activity.likes = math.Random().nextInt(tMaxLikes);
      _allActivities.add(activity);
      activityTypesSet.add(activity.type!);
    }
  }

  Future<void> _updateActivityLikes() async {
    final prefs = await SharedPreferences.getInstance();
    for (final activity in _allActivities) {
      activity.isLiked = prefs.getBool(activity.key!) ?? false;
    }
  }

  /// Filters activities by the given [selectedType].
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

  /// Filters activities by the given [price].
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

  /// Updates the slider value for price filtering and emits a new state.
  void updateSliderValue(double value) {
    if (state is ActivityLoaded) {
      currentSliderValue = value;
      filterActivitiesByPrice(currentSliderValue);
    }
  }

  /// Filters activities by the number of [participantCount].
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
