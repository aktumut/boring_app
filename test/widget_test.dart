import 'package:boring_app/business_logic/blocs/appbar/app_bar_cubit.dart';
import 'package:boring_app/presentation/widgets/home_page_widgets/call_to_action_button.dart';
import 'package:boring_app/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'widget_test.mocks.dart';

@GenerateMocks([AppBarCubit])
void main() {
  group('CallToActionButton Tests', () {
    late MockAppBarCubit mockAppBarCubit;

    setUp(() {
      mockAppBarCubit = MockAppBarCubit();
      when(mockAppBarCubit.state)
          .thenReturn(const AppBarExpanded()); // Provide a valid AppBarState
    });

    testWidgets(
        'should render CallToActionButton and handle button press correctly',
        (WidgetTester tester) async {
      // Arrange

      when(mockAppBarCubit.state).thenReturn(const AppBarExpanded());

      await tester.pumpWidget(
        MaterialApp(
          home: MultiBlocProvider(
            providers: [
              BlocProvider<AppBarCubit>(create: (context) => mockAppBarCubit),
            ],
            child: const CallToActionButton(),
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
