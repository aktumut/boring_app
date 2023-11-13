import 'package:boring_app/business_logic/blocs/activity/activity_cubit.dart';
import 'package:boring_app/business_logic/blocs/activity_like/activity_like_cubit.dart';
import 'package:boring_app/business_logic/blocs/appbar/app_bar_cubit.dart';
import 'package:boring_app/presentation/pages/home_page.dart';
import 'package:boring_app/utils/constants.dart';
import 'package:boring_app/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BoringApp extends StatelessWidget {
  final ActivityCubit activityCubit;
  final ScrollController scrollController;

  const BoringApp({
    super.key,
    required this.activityCubit,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => AppBarCubit(scrollController),
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
          scrollController: scrollController,
        ),
      ),
    );
  }
}
