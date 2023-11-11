import 'package:boring_app/business_logic/blocs/activity/activity_cubit.dart';
import 'package:boring_app/business_logic/blocs/activity_like/activity_like_cubit.dart';
import 'package:boring_app/business_logic/blocs/appbar/app_bar_cubit.dart';
import 'package:boring_app/utils/constants.dart';
import 'package:boring_app/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'presentation/pages/home/home_page.dart';

class BoringApp extends StatelessWidget {
  final ActivityCubit activityCubit;
  final ScrollController appBarScrollController;
  final ScrollController activityListScrollController;

  const BoringApp({
    super.key,
    required this.activityCubit,
    required this.appBarScrollController,
    required this.activityListScrollController,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => AppBarCubit(appBarScrollController),
        ),
        BlocProvider.value(
          value: activityCubit..fetchActivities(),
        ),
        BlocProvider(
          create: (BuildContext context) =>
              ActivityLikeCubit(activityCubit)..init(),
        ),
      ],
      child: MaterialApp(
        title: tTextAppName,
        theme: appThemeData,
        debugShowCheckedModeBanner: false,
        home: HomePage(
          appBarScrollController: appBarScrollController,
          activityListScrollController: activityListScrollController,
        ),
      ),
    );
  }
}
