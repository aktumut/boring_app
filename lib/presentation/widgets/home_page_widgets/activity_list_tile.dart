import 'package:boring_app/business_logic/blocs/activity_like/activity_like_cubit.dart';
import 'package:boring_app/data/models/activity_model.dart';
import 'package:boring_app/presentation/widgets/home_page_widgets/activity_list_tile_details.dart';
import 'package:boring_app/utils/activity_type_images.dart';
import 'package:boring_app/utils/constants.dart';
import 'package:boring_app/utils/theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActivityListTile extends StatelessWidget {
  final ActivityModel activity;

  const ActivityListTile({super.key, required this.activity});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: tSpaceDouble),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(tRadiusCard),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildActivityImageStack(context),
            ActivityListTileDetails(activity: activity),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityImageStack(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(tRadiusCard),
        topRight: Radius.circular(tRadiusCard),
      ),
      child: Stack(
        children: [
          CachedNetworkImage(
            imageUrl: activityTypeImages[activity.type] ??
                activityTypeImages[tTextNotFound]!,
            height: tHeightActivityListTile,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          BlocBuilder<ActivityLikeCubit, ActivityLikeState>(
            builder: (context, state) {
              return Positioned(
                right: tSpaceDouble,
                bottom: tSpaceBase,
                child: Row(
                  children: [
                    GestureDetector(
                      child: Icon(
                          activity.isLiked
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: tColorWhite,
                          size: tSizeActivityListTileFavoriIcon),
                      onTap: () {
                        context.read<ActivityLikeCubit>().toggleLike(activity);
                      },
                    ),
                    Text(activity.likes.toString(), style: tTextStyleHeader2),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
