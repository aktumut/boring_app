import 'package:boring_app/business_logic/repositories/activity_repository.dart';
import 'package:boring_app/data/models/activity_model.dart';
import 'package:boring_app/utils/constants.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'activity_state.dart';

class ActivityCubit extends Cubit<ActivityState> {
  final ActivityRepository _activityRepository;
  List<ActivityModel> _allActivities = [];
  List<String> activityTypes = [];

  ActivityCubit(this._activityRepository) : super(ActivityLoading());

  Future<void> fetchActivities() async {
    try {
      _allActivities = [];
      Set<String> activityTypesSet = {tTextAll};

      for (int i = 0; i < tNumberOfActivities; i++) {
        final ActivityModel activity =
            await _activityRepository.fetchActivity();
        _allActivities.add(activity);
        activityTypesSet.add(activity.type!);
      }

      activityTypes = activityTypesSet.toList();
      emit(ActivityLoaded(_allActivities, activityTypes, tTextAll));
    } catch (e) {
      emit(ActivityError(e.toString()));
    }
  }

  void filterActivities(String selectedType) {
    List<ActivityModel> filteredActivities = selectedType == tTextAll
        ? _allActivities
        : _allActivities
            .where((ActivityModel activity) => activity.type == selectedType)
            .toList();

    if (state is ActivityLoaded) {
      ActivityLoaded currentState = state as ActivityLoaded;
      emit(ActivityLoaded(
          filteredActivities, currentState.activityTypes, selectedType));
    }
  }
}
