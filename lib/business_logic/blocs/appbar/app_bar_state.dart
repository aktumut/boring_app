part of 'app_bar_cubit.dart';

/// The base state class for AppBar related states.
abstract class AppBarState extends Equatable {
  /// Constructor for [AppBarState].
  const AppBarState();
}

/// The state indicating that the AppBar is fully expanded.
class AppBarExpanded extends AppBarState {
  /// Constructor for [AppBarExpanded] state.
  const AppBarExpanded() : super();

  @override
  List<Object> get props => [];
}

/// The state indicating that the AppBar is collapsed.
class AppBarCollapsed extends AppBarState {
  /// Constructor for [AppBarCollapsed] state.
  const AppBarCollapsed() : super();

  @override
  List<Object> get props => [];
}

/// The state indicating that the AppBar is showing all filters
/// with a specific height.
class AppBarWithAllFilters extends AppBarState {
  /// Constructor for [AppBarWithAllFilters] state with the given height.
  const AppBarWithAllFilters(this.heightAppBarWithFilters) : super();

  /// The height of the AppBar when all filters are shown.
  final double heightAppBarWithFilters;

  @override
  List<Object> get props => [heightAppBarWithFilters];
}
