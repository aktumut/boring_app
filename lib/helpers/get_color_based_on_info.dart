import 'package:boring_app/utils/theme.dart';
import 'package:flutter/painting.dart';

Color getColorBasedOnInfo(double price) {
  final priceScore = (price * 10).toInt();
  if (0 < priceScore && priceScore < 3) {
    return tColorYellow.withOpacity(0.3);
  } else if (3 <= priceScore && priceScore < 7) {
    return tColorYellow.withOpacity(0.6);
  } else if (7 <= priceScore && priceScore <= 10) {
    return tColorYellow.withOpacity(0.9);
  } else {
    return tColorDarkGray;
  }
}
