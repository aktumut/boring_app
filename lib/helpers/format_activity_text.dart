import 'package:boring_app/utils/theme.dart';

String formatActivityText(String? text) {
  if (text != null && text.length > tLengthActivityListTileText) {
    return '${text.substring(0, tLengthActivityListTileText)}...';
  }
  return text ?? 'Random activity';
}
