import 'dart:io';

import 'package:palace/palace.dart';
import 'package:path/path.dart' as path;
import 'package:test/test.dart';

void main() {
  /// the time in the Naho <3 zone
  // final dt = DateTime(2021, 4, 1, 5, 40);
  final dt = DateTime.now();
  final logsDirectory = Directory(Directory.current.path + '\\logs\\');
  final logFile = File(path.join(logsDirectory.path + '${dt.year}-${dt.month}-${dt.day}.log'));
  setUp(() async {
    if (await logFile.exists()) await logFile.delete();
  });

  tearDown(() async {
    if (await logsDirectory.exists()) await logsDirectory.delete();
    if (await logFile.exists()) await logFile.delete();
  });
  test('log errors', () async {
    final logsInString = StringBuffer();
    final st = StackTrace.fromString('this is dummy stack trance form !');
    final e = Exception('this is dummy exception');
    for (var i = 0; i < 10; i++) {
      final msg = await Logger.l(e, st: st);
      logsInString.write(msg);
    }
    expect(await logFile.readAsString(), equals(logsInString.toString()));
  });
}
