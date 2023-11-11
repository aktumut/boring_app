String formatPrice(double price) {
  int priceInt = (price * 10).toInt();
  if (price == 0) {
    return 'Free!';
  } else if (priceInt < 1) {
    return '1/10';
  } else {
    return '$priceInt/10';
  }
}
