import 'package:boring_app/utils/theme.dart';

double determineAppBarHeight(int activityTypesLength) {
  if (5 < activityTypesLength && activityTypesLength <= 9) {
    return tHeightFinalAppBar6to8;
  } else if (2 < activityTypesLength && activityTypesLength <= 5) {
    return tHeightFinalAppBar3to5;
  } else if (0 < activityTypesLength && activityTypesLength <= 3) {
    return tHeightFinalAppBar1to2;
  } else {
    return tHeightFinalAppBar9to11;
  }
}
