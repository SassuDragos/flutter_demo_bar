import 'dart:ui';

import 'package:flutter_app/src/utils.dart';

class CompanyInfo {
  String _name;
  String _iconUrl;
  String _color;
  String _welcomeText;

  CompanyInfo.fromJson(Map<String, dynamic> parsedJson) {
    _iconUrl = parsedJson['iconUrl'];
    _name = parsedJson['name'];
    _welcomeText = parsedJson['welcomeText'];
    _color = parsedJson['color'];
  }

  String get iconUrl => _iconUrl;

  String get name => _name;

  Color get color => utils.getColorFromStringHex(_color);

  String get welcomeText => _welcomeText;
}
