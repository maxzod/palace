import 'dart:convert';

dynamic _customEncoder(dynamic item) {
  if (item is DateTime) {
    return item.toIso8601String();
  }
  return item;
}

String palaceJsonEncoder(Object? object) {
  if (object is String) {
    return object;
  } else {
    return jsonEncode(object, toEncodable: _customEncoder);
  }
}
