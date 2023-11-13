import 'package:boring_app/utils/theme.dart';

double determineAppBarHeight(int activityTypesLength) {
  if (6 < activityTypesLength && activityTypesLength <= 9) {
    return tHeightFinalAppBar6to8;
  } else if (3 < activityTypesLength && activityTypesLength <= 6) {
    return tHeightFinalAppBar3to5;
  } else if (0 < activityTypesLength && activityTypesLength <= 3) {
    return tHeightFinalAppBar1to2;
  } else {
    return tHeightFinalAppBar9to11;
  }
}
