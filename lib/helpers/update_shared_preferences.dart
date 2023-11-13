import 'package:shared_preferences/shared_preferences.dart';

Future<void> updateSharedPreferences(String key, bool isLiked) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool(key, isLiked);
}
