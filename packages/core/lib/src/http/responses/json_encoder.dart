import 'dart:convert';

dynamic _customEncoder(dynamic item) {
  print(item.runtimeType);
  if (item is DateTime) {
    return item.toIso8601String();
  } else if (item is Map) {
    return palaceJsonEncoder(item);
  } else if (item.runtimeType.toString() == 'Blob') {
    return item.toString();
  } else if (item is List) {
    // return 'item list';
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
