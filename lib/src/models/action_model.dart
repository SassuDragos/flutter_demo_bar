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
      case "offer_1":
        return ActionTypes.offer_1;
      case "offer_2":
        return ActionTypes.offer_2;
      case "offer_3":
        return ActionTypes.offer_3;
      case "check":
        return ActionTypes.check;
      case "one_more":
        return ActionTypes.one_more;
      case "surprise":
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
  offer_2,
  offer_3,
  check,
  one_more,
  surprise,
}
