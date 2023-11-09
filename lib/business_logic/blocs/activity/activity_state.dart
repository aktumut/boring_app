part of 'activity_cubit.dart';

abstract class ActivityState extends Equatable {
  const ActivityState();
}

class ActivityLoading extends ActivityState {
  @override
  List<Object> get props => [];
}

class ActivityLoaded extends ActivityState {
  ActivityLoaded(this.activities, this.activityTypes, this.selectedFilter);

  final List<ActivityModel> activities;
  final List<String> activityTypes;
  String selectedFilter = 'All';

  @override
  List<Object> get props => [activities, activityTypes, selectedFilter];
}

class ActivityError extends ActivityState {
  const ActivityError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
