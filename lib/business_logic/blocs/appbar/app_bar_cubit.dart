import 'dart:async';

import 'package:boring_app/utils/theme.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_bar_state.dart';

/// Manages the state of AppBar based on scroll events and provides animation for AppBar expansion.

class AppBarCubit extends Cubit<AppBarState> {
  final ScrollController _appBarScrollController;
  Timer? _timer;

  AppBarCubit(this._appBarScrollController) : super(AppBarExpanded()) {
    _appBarScrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final isAppBarExpanded =
        _appBarScrollController.offset < (tHeightAppBar - kToolbarHeight);
    emit(isAppBarExpanded ? AppBarExpanded() : const AppBarCollapsed());
  }

  void expandAppBarWithAllFilters(double finalAppBarHeight) {
    final stepTime =
        tDurationAppBarAnimation.inMilliseconds / tStepsAppBarAnimation;
    int currentStep = 0;

    _timer?.cancel();
    _timer = Timer.periodic(Duration(milliseconds: stepTime.toInt()), (timer) {
      currentStep++;
      double newHeight = _calculateNewHeight(currentStep, finalAppBarHeight);

      emit(AppBarWithAllFilters(newHeight));

      if (currentStep == tStepsAppBarAnimation) {
        timer.cancel();
      }
    });
  }

  double _calculateNewHeight(int currentStep, finalAppBarHeight) {
    if (currentStep <= tStepsAppBarAnimation / 2) {
      return tHeightAppBar +
          (currentStep *
              ((tHeightMaxAppBar - tHeightAppBar) /
                  (tStepsAppBarAnimation / 2)));
    } else {
      return tHeightMaxAppBar -
          ((currentStep - tStepsAppBarAnimation / 2) *
              ((tHeightMaxAppBar - finalAppBarHeight) /
                  (tStepsAppBarAnimation / 2)));
    }
  }

  void resetAppBar() {
    emit(AppBarExpanded());
  }

  @override
  Future<void> close() async {
    _timer?.cancel();
    _appBarScrollController.removeListener(_onScroll);
    _appBarScrollController.dispose();
    return super.close();
  }
}
