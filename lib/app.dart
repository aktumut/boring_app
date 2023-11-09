import 'package:boring_app/business_logic/blocs/appbar/app_bar_cubit.dart';
import 'package:boring_app/utils/constants.dart';
import 'package:boring_app/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'presentation/pages/home/home_page.dart';

class BoringApp extends StatelessWidget {
  const BoringApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => AppBarCubit()),
      ],
      child: MaterialApp(
        title: tTextAppName,
        theme: appThemeData,
        home: HomePage(),
      ),
    );
  }
}
