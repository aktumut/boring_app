part of 'activity_cubit.dart';

abstract class ActivityState extends Equatable {
  const ActivityState();
}

class ActivityLoading extends ActivityState {
  @override
  List<Object> get props => [];
}

class ActivityLoaded extends ActivityState {
  const ActivityLoaded(
    this.activities,
    this.activityTypes,
    this.selectedFilter,
    this.currentSliderValue,
  );

  final List<ActivityModel> activities;

  final List<String> activityTypes;

  final String selectedFilter;

  final double currentSliderValue;

  @override
  List<Object> get props =>
      [activities, activityTypes, selectedFilter, currentSliderValue];
}

class ActivityError extends ActivityState {
  const ActivityError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
