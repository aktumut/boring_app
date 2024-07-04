part of 'app_bar_cubit.dart';

abstract class AppBarState extends Equatable {
  const AppBarState();
}

class AppBarExpanded extends AppBarState {
  const AppBarExpanded() : super();

  @override
  List<Object> get props => [];
}

class AppBarCollapsed extends AppBarState {
  const AppBarCollapsed() : super();

  @override
  List<Object> get props => [];
}

class AppBarWithAllFilters extends AppBarState {
  const AppBarWithAllFilters(this.heightAppBarWithFilters) : super();

  final double heightAppBarWithFilters;

  @override
  List<Object> get props => [heightAppBarWithFilters];
}
