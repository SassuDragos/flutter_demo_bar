class Action {
  int _id;
  String _iconUrl;
  String _name;

  Action.fromJson(Map<String, dynamic> parsedJson) {
    _id = parsedJson['id'];
    _iconUrl = parsedJson['iconUrl'];
    _name = parsedJson['name'];
  }

  int get id => _id;

  String get iconUrl => _iconUrl;

  String get name => _name;
}

