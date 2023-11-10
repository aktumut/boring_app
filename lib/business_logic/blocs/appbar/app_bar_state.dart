part of 'app_bar_cubit.dart';

abstract class AppBarState extends Equatable {
  AppBarState();
}

class AppBarExpanded extends AppBarState {
  AppBarExpanded() : super();

  @override
  List<Object> get props => [];
}

class AppBarCollapsed extends AppBarState {
  AppBarCollapsed() : super();

  @override
  List<Object> get props => [];
}

class AppBarWithAllFilters extends AppBarState {
  double heightAppBarWithFilters;

  AppBarWithAllFilters(this.heightAppBarWithFilters) : super();

  @override
  List<Object> get props => [heightAppBarWithFilters];
}
