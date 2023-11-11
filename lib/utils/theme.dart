import 'package:boring_app/utils/constants.dart';
import 'package:flutter/material.dart';

// Theme Data
final ThemeData appThemeData = ThemeData(
  primarySwatch: tMaterialColorPrimary,
  fontFamily: 'Roboto-Regular',
  visualDensity: VisualDensity.adaptivePlatformDensity,
);

// Spacings and Paddings
const double tSpaceEighth = 1;
const double tSpaceQuarter = 2;
const double tSpaceHalf = 4;
const double tSpaceSmall = 6;
const double tSpaceBase = 8;
const double tSpace = 12;
const double tSpaceDouble = 16;
const double tSpaceVerticalPadding = 24;
const double tSpaceHorizontalPadding = 24;
const double tSpaceDoubleHorizontalPadding = 48;
const double tSpaceHalfHorizontalPadding = 16;
const double tSpaceDoubleVerticalPadding = 48;
const double tShapeHeight = 104;

// Appbar
const double tHeightAppBar = 200;
const double tHeightMaxAppBar = 512;
const double tHeightFinalAppBar9to11 = 468;
const double tHeightFinalAppBar6to8 = 360;
const double tHeightFinalAppBar3to5 = 256;
const double tHeightFinalAppBar1to2 = 152;
const Duration tDurationAppBarAnimation = Duration(milliseconds: 500);
const int tStepsAppBarAnimation = 100;

// Activity List Tile
const double tHeightActivityListTile = 152;
const double tSizeActivityListTileIcon = 16;
const double tSizeActivityListTilePriceIcon = 24;
const double tSizeActivityListTileFavoriIcon = 24;
const int tLengthActivityListTileText = 24;
const double tRadiusCard = 16;

// Button
const double tRadiusButton = 8;
const double tHeightButton = 48;

// Filter Widget
const double tHeightFilterWidget = 96;
const double tWidthFilterWidget = 96;
const double tRadiusFilterWidget = 16;
const double tWidthBorderFilterWidget = 4;
const double tSizeIconFilterWidget = 48;

// Font Sizes
const double tFontSizeTiny = 12;
const double tFontSizeSmall = 16;
const double tFontSizeMedium = 24;
const double tFontSizeLarge = 40;
const double tFontSizeButton = 20;
const double tFontSizeFilterIcon = 14;

// Colors
const Color tColorPrimary = Color(0xFFFE7B20);
const Color tColorWhite = Color(0xFFFFFFFF);
const Color tColorLightGray = Color(0xFFE6EFF1);
const Color tColorGray = Color(0xFFE7E7E6);
const Color tColorDarkGray = Color(0xFF9B9B9B);
const Color tColorBlack = Color(0xFF000000);
const Color tColorYellow = Color(0xFFB49B00);
const Color tColorsTransparent = Colors.transparent;

// Material Color
const MaterialColor tMaterialColorPrimary = MaterialColor(
  0xFFFE7B20,
  <int, Color>{
    50: Color(0x0FF9ED14),
    100: Color(0xFFAE5516),
    200: Color(0xFFBF5D18),
    300: Color(0xFFD2661A),
    400: Color(0xFFE7701D),
    500: Color(0xFFFE7B20),
    600: Color(0xFFFD9838),
    700: Color(0xFFFDA14A),
    800: Color(0xFFFDAA5A),
    900: Color(0xFFFDB269),
  },
);

const TextStyle tTextStyleHeader1 = TextStyle(
  fontSize: tFontSizeLarge,
  color: tColorWhite,
  fontFamily: tTextBoldFont,
  height: 1.5,
);

const TextStyle tTextStyleHeader2 = TextStyle(
  fontSize: tFontSizeMedium,
  color: tColorWhite,
  fontFamily: tTextBoldFont,
  height: 1,
);

const TextStyle tTextStyleHeader3 = TextStyle(
  fontSize: tFontSizeSmall,
  color: tColorGray,
  fontFamily: tTextBoldFont,
  height: 1,
);

const TextStyle tTextStyleButton = TextStyle(
  fontSize: tFontSizeButton,
  fontFamily: tTextBoldFont,
  height: 1,
);

const TextStyle tTextStyleFilterIcon = TextStyle(
  fontSize: tFontSizeFilterIcon,
  color: tColorWhite,
  fontFamily: tTextBoldFont,
  height: 1,
);

const TextStyle tTextStyleActivityListTileHeader = TextStyle(
  fontSize: tFontSizeSmall,
  color: tColorPrimary,
  fontFamily: tTextBoldFont,
  height: 1,
);

const TextStyle tTextStyleActivityListTileSubHeader = TextStyle(
  fontSize: tFontSizeTiny,
  color: tColorDarkGray,
  fontFamily: tTextRegularFont,
  height: 1,
);

const TextStyle tTextStyleActivityListTileActivity = TextStyle(
  fontSize: tFontSizeSmall,
  color: tColorBlack,
  fontFamily: tTextBoldFont,
  height: 1,
);