import 'dart:async';

import 'package:boring_app/business_logic/blocs/activity/activity_cubit.dart';
import 'package:boring_app/business_logic/blocs/appbar/app_bar_cubit.dart';
import 'package:boring_app/data/models/activity_model.dart';
import 'package:boring_app/presentation/widgets/home_page_widgets/call_to_action_button.dart';
import 'package:boring_app/utils/constants.dart';
import 'package:boring_app/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'widget_test.mocks.dart';

@GenerateMocks([AppBarCubit, ActivityCubit])
void main() {
  group('CallToActionButton Tests', () {
    late MockAppBarCubit mockAppBarCubit;
    late MockActivityCubit mockActivityCubit;
    late StreamController<AppBarState> appBarStateController;
    late StreamController<ActivityState> activityStateController;

    setUp(() {
      mockAppBarCubit = MockAppBarCubit();
      mockActivityCubit = MockActivityCubit();
      when(mockActivityCubit.activityTypes).thenReturn(
        ['ActivityType1', 'ActivityType2'],
      ); // Provide appropriate values

      appBarStateController = StreamController<AppBarState>.broadcast();
      activityStateController = StreamController<ActivityState>.broadcast();

      // Stub the stream for AppBarCubit and ActivityCubit
      when(mockAppBarCubit.stream)
          .thenAnswer((_) => appBarStateController.stream);
      when(mockActivityCubit.stream)
          .thenAnswer((_) => activityStateController.stream);

      // Stub the state getter
      when(mockAppBarCubit.state).thenReturn(const AppBarExpanded());
      when(mockActivityCubit.state).thenReturn(
        const ActivityLoaded(
          [
            ActivityModel(
              activity: 'activity',
              type: 'type',
              participants: 1,
              price: 0.1,
              link: 'link',
              key: 'key',
              accessibility: 0.1,
            ),
          ],
          [
            'type',
          ],
          tTextFilterAll,
          1,
        ),
      ); // Provide appropriate state
    });

    tearDown(() {
      appBarStateController.close();
      activityStateController.close();
    });

    testWidgets(
        'should render CallToActionButton and handle button press correctly',
        (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        MaterialApp(
          home: MultiBlocProvider(
            providers: [
              BlocProvider<AppBarCubit>(create: (context) => mockAppBarCubit),
              BlocProvider<ActivityCubit>(
                create: (context) => mockActivityCubit,
              ),
            ],
            child: const Stack(
              children: [
                CallToActionButton(),
              ],
            ),
          ),
        ),
      );

      // Act
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(CallToActionButton), findsOneWidget);
      verify(mockAppBarCubit.expandAppBarWithAllFilters(tHeightFinalAppBar1to2))
          .called(1);
    });
  });
}
