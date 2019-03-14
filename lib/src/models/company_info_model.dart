class CompanyInfo {
  String _name;
  String _iconUrl;

  CompanyInfo.fromJson(Map<String, dynamic> parsedJson) {
    _iconUrl = parsedJson['iconUrl'];
    _name = parsedJson['name'];
  }

  String get iconUrl => _iconUrl;

  String get name => _name;
}
