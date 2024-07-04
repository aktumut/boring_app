import 'package:boring_app/app.dart';
import 'package:boring_app/business_logic/blocs/activity/activity_cubit.dart';
import 'package:boring_app/business_logic/repositories/activity_repository.dart';
import 'package:boring_app/data/providers/network_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );

  final app = initializeApp();

  runApp(app);
}

Widget initializeApp() {
  final networkProvider = NetworkProvider();
  final activityRepository = ActivityRepository(networkProvider);
  final scrollController = ScrollController();
  final activityCubit = ActivityCubit(activityRepository, scrollController)
    ..fetchActivities();

  return BoringApp(
    scrollController: scrollController,
    activityCubit: activityCubit,
  );
}
