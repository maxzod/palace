import 'dart:io';

import 'package:yaml/yaml.dart';

String? _data;
dynamic? _yaml;
void _init() {
  _data ??= File('${Directory.current.path}/.yaml').readAsStringSync();
  _yaml ??= loadYaml(_data!);
}

T config<T>(String key) {
  if (_data == null) _init();
  return _yaml[key] as T;
}