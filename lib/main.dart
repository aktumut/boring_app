import 'package:boring_app/app.dart';
import 'package:boring_app/business_logic/blocs/activity/activity_cubit.dart';
import 'package:boring_app/business_logic/repositories/activity_repository.dart';
import 'package:boring_app/data/providers/network_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

  final Widget app = initializeApp();

  runApp(app);
}

Widget initializeApp() {
  final NetworkProvider networkProvider = NetworkProvider();
  final ActivityRepository activityRepository =
      ActivityRepository(networkProvider);
  final ScrollController appBarScrollController = ScrollController();
  final ScrollController activityListScrollController = ScrollController();
  final ActivityCubit activityCubit =
      ActivityCubit(activityRepository, activityListScrollController)
        ..fetchActivities();

  return BoringApp(
    activityCubit: activityCubit,
    appBarScrollController: appBarScrollController,
    activityListScrollController: activityListScrollController,
  );
}
