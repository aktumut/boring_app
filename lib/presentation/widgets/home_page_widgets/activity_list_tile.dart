import 'package:boring_app/data/models/activity_model.dart';
import 'package:boring_app/presentation/widgets/fav_icon.dart';
import 'package:boring_app/presentation/widgets/home_page_widgets/activity_list_tile_details.dart';
import 'package:boring_app/presentation/widgets/image_widget.dart';
import 'package:boring_app/utils/theme.dart';
import 'package:flutter/material.dart';

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
          ImageWidget(
            activity: activity,
            isShadow: false,
          ),
          FavIcon(
            activity: activity,
          ),
        ],
      ),
    );
  }
}
