import 'package:boring_app/data/models/activity_model.dart';
import 'package:boring_app/data/providers/network_provider.dart';

class ActivityRepository {
  ActivityRepository(this._networkProvider);

  final NetworkProvider _networkProvider;

  final Set<String> _activityTypes = {};

  Future<ActivityModel> fetchActivity() async {
    final response =
        await _networkProvider.get<Map<String, dynamic>>('/activity');
    if (response.statusCode == 200) {
      final data = response.data!;

      final activity = ActivityModel.fromJson(data);
      _activityTypes.add(activity.type!);
      return activity;
    } else {
      throw Exception('Failed to fetch activity');
    }
  }

  List<String> get activityTypes => _activityTypes.toList();
}
