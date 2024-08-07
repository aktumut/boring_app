import 'package:boring_app/utils/text_style_theme.dart';
import 'package:boring_app/utils/theme.dart';
import 'package:flutter/material.dart';

class InformationWidget extends StatelessWidget {
  const InformationWidget({
    required this.informationIconText,
    required this.informationIconWidget,
    super.key,
  });

  final String informationIconText;
  final Widget informationIconWidget;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(tSpaceBase),
      height: tHeightInformationWidget,
      width: tWidthInformationWidget,
      decoration: BoxDecoration(
        color: tColorPrimary,
        borderRadius: BorderRadius.circular(tRadiusInformationWidget),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          informationIconWidget,
          Container(
            padding: const EdgeInsets.only(top: tSpaceHalf),
            child: Text(
              informationIconText,
              style: tTextStyleRegular.copyWith(color: tColorWhite),
            ),
          ),
        ],
      ),
    );
  }
}
