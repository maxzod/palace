import 'dart:io';

import 'package:palace/palace.dart';
import 'package:test/test.dart';

void main() {
  final yamlFile = File('${Directory.current.path}/.yaml');
  setUp(() async {
    if (await yamlFile.exists()) {
      await yamlFile.delete();
    }
  });

  tearDown(() async {
    if (await yamlFile.exists()) {
      await yamlFile.delete();
    }
  });
  test('throw error if not exist', () async {
    dynamic exception;
    try {
      await yaml('app_name');
    } catch (e) {
      exception = e;
    }
    expect(
      exception,
      equals('There is not .yaml file in your project make sure it exist !'),
    );
  });
  test('return null value in case of the file exist but the key is not', () async {
    await yamlFile.create();
    await yamlFile.writeAsString('app_name: someAppName');

    final _notExistingValue = await yaml('some_unknown_key');
    expect(_notExistingValue, equals(null));
  });
  test('return value', () async {
    final _appName = await yaml('app_name');
    expect(_appName, 'someAppName');
  });
}
