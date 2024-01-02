part of 'activity_like_cubit.dart';

/// The base state class for activity like states.
abstract class ActivityLikeState extends Equatable {
  /// Constructor for `ActivityLikeState`.
  const ActivityLikeState();
}

/// The initial state when the activity like feature has not been interacted wit
class ActivityLikeInitial extends ActivityLikeState {
  @override
  List<Object> get props => [];
}

/// The state representing an update to the like status of an activity.
class ActivityLikeUpdate extends ActivityLikeState {
  /// Constructor for `ActivityLikeUpdate` state.
  /// Receives the new [isLiked] status and the updated [numberOfLikes]
  /// for an activity.
  const ActivityLikeUpdate({
    required this.numberOfLikes,
    this.isLiked = false,
  });

  /// The total number of likes for the activity.
  final int numberOfLikes;

  /// Whether the activity is liked or not.
  final bool isLiked;

  @override
  List<Object> get props => [isLiked, numberOfLikes];
}
