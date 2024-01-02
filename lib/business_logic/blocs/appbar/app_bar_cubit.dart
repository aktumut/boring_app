import 'dart:async';

import 'package:boring_app/utils/theme.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_bar_state.dart';

/// Manages the state of AppBar based on scroll events and provides
/// animation for AppBar expansion.
class AppBarCubit extends Cubit<AppBarState> {
  /// Creates an instance of [AppBarCubit] with an attached [ScrollController].
  ///
  /// Initially, the state is set to [AppBarExpanded].
  AppBarCubit(this._scrollController) : super(const AppBarExpanded()) {
    _scrollController.addListener(_onScroll);
  }

  final ScrollController _scrollController;

  Timer? _timer;

  void _onScroll() {
    final isAppBarExpanded =
        _scrollController.offset < (tHeightAppBar - kToolbarHeight);

    emit(isAppBarExpanded ? const AppBarExpanded() : const AppBarCollapsed());
  }

  /// Initiates an animation to expand the app bar height with a filter section.
  ///
  /// [finalAppBarHeight] is the height the app bar animates to.
  void expandAppBarWithAllFilters(double finalAppBarHeight) {
    final stepTime =
        tDurationAppBarAnimation.inMilliseconds / tStepsAppBarAnimation;
    var currentStep = 0;

    _timer?.cancel();
    _timer = Timer.periodic(Duration(milliseconds: stepTime.toInt()), (timer) {
      currentStep++;
      final newHeight = _calculateNewHeight(currentStep, finalAppBarHeight);

      emit(AppBarWithAllFilters(newHeight));

      if (currentStep == tStepsAppBarAnimation) {
        timer.cancel();
      }
    });
  }

  double _calculateNewHeight(int currentStep, num finalAppBarHeight) {
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

  /// Resets the app bar to its expanded state.
  void resetAppBar() {
    emit(const AppBarExpanded());
  }

  @override
  Future<void> close() async {
    _timer?.cancel();
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    return super.close();
  }
}
