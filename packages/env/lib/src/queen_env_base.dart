import 'dart:io' show File;

import 'package:env/src/env_parser.dart';

/// env file keys
final _keys = <String>{};
final _values = <String, dynamic>{};

/// load env file
Future<void> loadEnv([String path = '.env']) async {
  final env = File(path);
  if (!(await env.exists())) {
    throw '$path does not exist';
  }
  final lines = await env.readAsLines();
  for (final fullLine in lines) {
    final line = fullLine.trim();
    if (line.isNotEmpty && !isAComment(line)) {
      final lineKey = extractKey(line);
      final lineValue = extractValue(line);
      _keys.add(lineKey);
      _values.addAll({lineKey: lineValue});
    }
  }
}

// /// reload
// Future<void> reload([String path = '.env']) async {
//   _keys.clear();
//   _values.clear();

//   return loadEnv(path);
// }

///  get value from the env file by the key
///  if the key is null it will reutrn empty String
String env(String key) {
  return envOrNull(key) ?? '';
}

///  get value from the env file by the key
String? envOrNull(String key) {
  return _values[key] as String?;
}

Set<String> get envKeys => _keys;
