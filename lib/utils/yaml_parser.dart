import 'dart:io';

import 'package:yaml/yaml.dart';

/// load and extract yaml file attribute by the parent key
Future<T?> yaml<T>(String key) async => _YamlParser.yaml<T>(key);

class _YamlParser {
  /// the formatted content of the yaml file
  static dynamic? _yaml;

  static Future<void> _init() async {
    final _yamlFile = File('${Directory.current.path}/.yaml');
    if (_yaml == null) {
      final fileExists = await _yamlFile.exists();
      if (!fileExists) {
        throw 'There is not .yaml file in your project make sure it exist !';
      }
    }
    final _data = _yamlFile.readAsStringSync();
    _yaml = loadYaml(_data);
  }

  static Future<T?> yaml<T>(String key) async {
    if (_yaml == null) await _YamlParser._init();
    return _yaml[key] as T;
  }
}

Future<bool?> get isInProduction async => _YamlParser.yaml<bool>('production');
Future<bool?> get allowLogs async => _YamlParser.yaml<bool>('allowLogs');