import 'dart:async';

import 'package:boring_app/business_logic/blocs/activity/activity_cubit.dart';
import 'package:boring_app/data/models/activity_model.dart';
import 'package:boring_app/helpers/update_shared_preferences.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'activity_like_state.dart';

class ActivityLikeCubit extends Cubit<ActivityLikeState> {
  ActivityLikeCubit(this.activityCubit) : super(ActivityLikeInitial());

  final ActivityCubit activityCubit;

  late final StreamSubscription<ActivityState> activitySubscription;

  List<ActivityModel> _allActivities = [];

  void init() {
    final currentState = activityCubit.state;
    if (currentState is ActivityLoaded) {
      _allActivities = currentState.activities;
    }

    activitySubscription = activityCubit.stream.listen(
      (ActivityState state) {
        if (state is ActivityLoaded) {
          _allActivities = state.activities;
        }
      },
    );
  }

  void toggleLike(ActivityModel activity) {
    final index =
        _allActivities.indexWhere((ActivityModel a) => a.key == activity.key);
    if (index != -1) {
      final updatedActivity = _allActivities[index].copyWith(
        isLiked: !_allActivities[index].isLiked,
        likes: _allActivities[index].isLiked
            ? _allActivities[index].likes - 1
            : _allActivities[index].likes + 1,
      );
      _allActivities[index] = updatedActivity;

      updateSharedPreferences(
        _allActivities[index].key!,
        isLiked: _allActivities[index].isLiked,
      );

      emit(
        ActivityLikeUpdate(
          isLiked: _allActivities[index].isLiked,
          numberOfLikes: _allActivities[index].likes,
        ),
      );
    }
  }

  @override
  Future<void> close() {
    activitySubscription.cancel();
    return super.close();
  }
}
