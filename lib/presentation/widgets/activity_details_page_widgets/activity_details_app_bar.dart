import 'package:boring_app/utils/theme.dart';
import 'package:flutter/material.dart';

class ActivityDetailsAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const ActivityDetailsAppBar({
    super.key,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(
          Icons.keyboard_arrow_left_sharp,
          size: tSizeIconAppBar,
          color: tColorWhite,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      elevation: 0,
    );
  }
}
