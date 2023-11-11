part of 'activity_like_cubit.dart';

abstract class ActivityLikeState extends Equatable {
  const ActivityLikeState();
}

class ActivityLikeInitial extends ActivityLikeState {
  @override
  List<Object> get props => [];
}

class ActivityLikeUpdate extends ActivityLikeState {
  ActivityLikeUpdate(this.isLiked, this.numberOfLikes);


  bool isLiked = false;
  int numberOfLikes;

  @override
  List<Object> get props => [isLiked, numberOfLikes];
}
