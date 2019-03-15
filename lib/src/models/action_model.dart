class Action {
  int _id;
  String _iconUrl;
  String _name;
  ActionTypes _type;

  Action.fromJson(Map<String, dynamic> parsedJson) {
    _id = parsedJson['id'];
    _iconUrl = parsedJson['iconUrl'];
    _name = parsedJson['name'];
    _type = actionTypeFromString(parsedJson['type']);
  }
  ActionTypes actionTypeFromString(String actionTypeString) {
    switch (actionTypeString) {
      case "Tuborg offer 3+1":
        return ActionTypes.offer_1;
      case "Check please":
        return ActionTypes.check;
      case "One more round":
        return ActionTypes.one_more;
      case "Surprise me!":
        return ActionTypes.surprise;
    }
  }

  int get id => _id;

  String get iconUrl => _iconUrl;

  String get name => _name;

  ActionTypes get actionType => _type;
}

enum ActionTypes {
  offer_1,
  check,
  one_more,
  surprise,
}
