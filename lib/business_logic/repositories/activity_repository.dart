import 'package:boring_app/data/models/activity_model.dart';
import 'package:boring_app/data/providers/network_provider.dart';
import 'package:dio/dio.dart';

class ActivityRepository {
  final NetworkProvider _networkProvider;

  final Set<String> _activityTypes = {};

  ActivityRepository(this._networkProvider);

  Future<ActivityModel> fetchActivity() async {
    final Response<dynamic> response = await _networkProvider.get('/activity');
    if (response.statusCode == 200) {
      final ActivityModel activity = ActivityModel.fromJson(response.data);
      _activityTypes.add(activity.type!);
      return activity;
    } else {
      throw Exception('Failed to fetch activity');
    }
  }

  List<String> get activityTypes => _activityTypes.toList();
}
