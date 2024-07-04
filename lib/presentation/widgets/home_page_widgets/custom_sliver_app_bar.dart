import 'package:boring_app/business_logic/blocs/appbar/app_bar_cubit.dart';
import 'package:boring_app/presentation/widgets/home_page_widgets/extended_filter_list.dart';
import 'package:boring_app/presentation/widgets/home_page_widgets/filter_icon_list.dart';
import 'package:boring_app/utils/constants.dart';
import 'package:boring_app/utils/text_style_theme.dart';
import 'package:boring_app/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBarCubit, AppBarState>(
      builder: (BuildContext context, AppBarState state) {
        return SliverAppBar(
          title: state is AppBarExpanded
              ? null
              : const Text(
                  tTextSlogan,
                  style: tTextStyleHeader2,
                ),
          elevation: 0,
          expandedHeight: state is AppBarWithAllFilters
              ? state.heightAppBarWithFilters
              : tHeightAppBar,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: false,
            titlePadding: EdgeInsets.zero,
            collapseMode: CollapseMode.pin,
            background: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: tSpaceHorizontalPadding,
                ),
                child: state is AppBarWithAllFilters
                    ? _extendedFlexibleSpaceContent()
                    : _customFlexibleSpaceContent(),
              ),
            ),
          ),
        );
      },
    );
  }

  Column _customFlexibleSpaceContent() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          tTextActivity,
          style: tTextStyleHeader3,
        ),
        Text(
          tTextSlogan,
          style: tTextStyleHeader1,
        ),
        FilterIconList(),
      ],
    );
  }

  Widget _extendedFlexibleSpaceContent() {
    return const SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: EdgeInsets.only(top: tSpaceDoubleVerticalPadding),
          child: ExtendedFilterList(),
        ),
      ),
    );
  }
}
