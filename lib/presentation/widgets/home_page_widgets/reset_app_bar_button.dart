import 'package:boring_app/business_logic/blocs/appbar/app_bar_cubit.dart';
import 'package:boring_app/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetAppBarButton extends StatelessWidget {
  const ResetAppBarButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: IconButton(
          icon: const Icon(
            Icons.keyboard_arrow_up_sharp,
            color: tColorWhite,
            size: tSizeIconFilterWidget,
          ),
          onPressed: () {
            context.read<AppBarCubit>().resetAppBar();
          }),
    );
  }
}
