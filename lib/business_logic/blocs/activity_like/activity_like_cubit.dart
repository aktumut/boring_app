import 'dart:async';

import 'package:boring_app/business_logic/blocs/activity/activity_cubit.dart';
import 'package:boring_app/data/models/activity_model.dart';
import 'package:boring_app/helpers/update_shared_preferences.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'activity_like_state.dart';

class ActivityLikeCubit extends Cubit<ActivityLikeState> {
  final ActivityCubit activityCubit;
  late final StreamSubscription activitySubscription;
  List<ActivityModel> _allActivities = [];

  ActivityLikeCubit(this.activityCubit) : super(ActivityLikeInitial());

  void init() {
    final ActivityState currentState = activityCubit.state;
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
    int index =
        _allActivities.indexWhere((ActivityModel a) => a.key == activity.key);
    if (index != -1) {
      _allActivities[index].isLiked = !_allActivities[index].isLiked;
      _allActivities[index].likes += _allActivities[index].isLiked ? 1 : -1;
      updateSharedPreferences(
          _allActivities[index].key!, _allActivities[index].isLiked);
      emit(ActivityLikeUpdate(
          _allActivities[index].isLiked, _allActivities[index].likes));
    }
  }

  @override
  Future<void> close() {
    activitySubscription.cancel();
    return super.close();
  }
}
