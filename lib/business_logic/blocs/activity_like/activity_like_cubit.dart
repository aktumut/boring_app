import 'dart:async';

import 'package:boring_app/business_logic/blocs/activity/activity_cubit.dart';
import 'package:boring_app/data/models/activity_model.dart';
import 'package:boring_app/helpers/update_shared_preferences.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'activity_like_state.dart';

/// Manages the like state of activities.
class ActivityLikeCubit extends Cubit<ActivityLikeState> {
  /// Initializes the [ActivityLikeCubit] with the [ActivityCubit].
  ActivityLikeCubit(this.activityCubit) : super(ActivityLikeInitial());

  /// Reference to the [ActivityCubit] to react to its state changes.
  final ActivityCubit activityCubit;

  /// Subscription to the [ActivityCubit]'s state stream.
  late final StreamSubscription<ActivityState> activitySubscription;

  /// Local cache of all activities to manage their like states.
  List<ActivityModel> _allActivities = [];

  /// Initializes the cubit by subscribing to the [activityCubit] stream.
  void init() {
    final currentState = activityCubit.state;
    if (currentState is ActivityLoaded) {
      _allActivities = currentState.activities;
    }

    // Listen to activity state changes.
    activitySubscription = activityCubit.stream.listen(
      (ActivityState state) {
        if (state is ActivityLoaded) {
          _allActivities = state.activities;
        }
      },
    );
  }

  /// Toggles the like state of an [activity] and updates the UI and storage.
  void toggleLike(ActivityModel activity) {
    final index =
        _allActivities.indexWhere((ActivityModel a) => a.key == activity.key);
    if (index != -1) {
      _allActivities[index].isLiked = !_allActivities[index].isLiked;
      _allActivities[index].likes += _allActivities[index].isLiked ? 1 : -1;

      // Update the shared preferences with the new like state.
      updateSharedPreferences(
        _allActivities[index].key!,
        _allActivities[index].isLiked,
      );

      // Emit an update to the state with the new like count.
      emit(
        ActivityLikeUpdate(
          isLiked: _allActivities[index].isLiked,
          numberOfLikes: _allActivities[index].likes,
        ),
      );
    }
  }

  /// Cancels the subscription when the cubit is closed.
  @override
  Future<void> close() {
    activitySubscription.cancel();
    return super.close();
  }
}
