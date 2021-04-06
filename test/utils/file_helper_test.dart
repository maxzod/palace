import 'dart:io';

import 'package:palace/palace.dart';
import 'package:path/path.dart';
import 'package:test/test.dart';

void main() {
  late File file;
  setUp(() async {
    file = File(join(Directory.current.path, 'test_file.royal'));
    await file.create();
  });
  tearDown(() async {
    await file.delete();
  });
  test('getFileName(File file)', () async {
    final fileName = getFileName(file);
    expect(fileName, 'test_file.royal');
  });
}
