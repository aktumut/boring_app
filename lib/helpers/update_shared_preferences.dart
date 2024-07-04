import 'package:shared_preferences/shared_preferences.dart';

Future<void> updateSharedPreferences(
  String key, {
  required bool isLiked,
}) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool(key, isLiked);
}
