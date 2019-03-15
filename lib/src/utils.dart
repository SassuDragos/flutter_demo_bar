import 'dart:ui';

class Utils {
  Color getColorFromStringHex(String stringHex) {
    return Color(int.parse(stringHex.substring(1, 7), radix: 16) + 0xFF000000);
  }
}

final Utils utils = Utils();
