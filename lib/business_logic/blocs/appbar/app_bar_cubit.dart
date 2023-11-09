import 'package:bloc/bloc.dart';
import 'package:boring_app/utils/theme.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'app_bar_state.dart';

class AppBarCubit extends Cubit<AppBarState> {
  final ScrollController scrollController = ScrollController();

  AppBarCubit() : super(AppBarExpanded()) {
    scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final bool isAppBarExpanded =
        scrollController.offset < (tHeightAppBar - kToolbarHeight);
    emit(isAppBarExpanded ? AppBarExpanded() : AppBarCollapsed());
  }

  @override
  Future<void> close() {
    scrollController.removeListener(_onScroll);
    scrollController.dispose();
    return super.close();
  }
}
