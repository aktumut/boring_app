part of 'app_bar_cubit.dart';

abstract class AppBarState extends Equatable {
  const AppBarState();
}

class AppBarExpanded extends AppBarState {
  @override
  List<Object> get props => [];
}

class AppBarCollapsed extends AppBarState {
  @override
  List<Object> get props => [];
}
