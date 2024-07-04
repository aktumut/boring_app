import 'package:boring_app/business_logic/blocs/activity_like/activity_like_cubit.dart';
import 'package:boring_app/data/models/activity_model.dart';
import 'package:boring_app/utils/text_style_theme.dart';
import 'package:boring_app/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavIcon extends StatelessWidget {
  const FavIcon({
    required this.activity,
    super.key,
  });

  final ActivityModel activity;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ActivityLikeCubit, ActivityLikeState>(
      builder: (BuildContext context, ActivityLikeState state) {
        return Positioned(
          right: tSpaceDouble,
          bottom: tSpaceBase,
          child: Row(
            children: [
              GestureDetector(
                child: Icon(
                  activity.isLiked ? Icons.favorite : Icons.favorite_border,
                  color: tColorWhite,
                  size: tSizeActivityListTileFavoriIcon,
                ),
                onTap: () {
                  context.read<ActivityLikeCubit>().toggleLike(activity);
                },
              ),
              Text(activity.likes.toString(), style: tTextStyleHeader2),
            ],
          ),
        );
      },
    );
  }
}
