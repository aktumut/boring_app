import 'package:boring_app/business_logic/blocs/appbar/app_bar_cubit.dart';
import 'package:boring_app/helpers/bottom_bouncing_scroll_physics.dart';
import 'package:boring_app/presentation/widgets/home_page_widgets/activity_list.dart';
import 'package:boring_app/presentation/widgets/home_page_widgets/call_to_action_button.dart';
import 'package:boring_app/presentation/widgets/home_page_widgets/curved_shape_painter.dart';
import 'package:boring_app/presentation/widgets/home_page_widgets/custom_sliver_app_bar.dart';
import 'package:boring_app/presentation/widgets/home_page_widgets/reset_app_bar_button.dart';
import 'package:boring_app/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    required this.scrollController,
    super.key,
  });

  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBarCubit, AppBarState>(
      builder: (BuildContext context, AppBarState state) {
        return Scaffold(
          body: CustomScrollView(
            physics: state is! AppBarWithAllFilters
                ? const BottomBouncingScrollPhysics()
                : const NeverScrollableScrollPhysics(),
            controller: scrollController,
            shrinkWrap: true,
            slivers: <Widget>[
              const CustomSliverAppBar(),
              SliverToBoxAdapter(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: <Widget>[
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      height: tShapeHeight,
                      child: CustomPaint(
                        painter: CurvedShapePainter(),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: tSpaceHorizontalPadding,
                        vertical: tSpaceDoubleVerticalPadding,
                      ),
                      child: ActivityList(),
                    ),
                    if (state is! AppBarWithAllFilters)
                      const CallToActionButton(),
                    if (state is AppBarWithAllFilters)
                      const ResetAppBarButton(),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
