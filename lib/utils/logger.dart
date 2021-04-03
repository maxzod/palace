import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';

class PalaceLogger {
  static DateTime get dt => DateTime.now();
  static Directory get logFolder => Directory(Directory.current.path + '\\logs\\');
  static FutureOr<File> get logFile async {
    final fileName = join(logFolder.path + '${dt.year}-${dt.month}-${dt.day}.log');
    final _logFile = File(fileName);
    if (!await File(fileName).exists()) await _logFile.create();
    return _logFile;
  }

  static Future<void> e(Object e) async {
    await (await logFile).writeAsString('\n ERROR: [${dt.toIso8601String()}] $e', mode: FileMode.append);
  }

  static Future<void> l(Object e) async {
    await (await logFile).writeAsString('\n LOG: [${dt.toIso8601String()}] $e', mode: FileMode.append);
  }

  static Future<void> i(Object e) async {
    await (await logFile).writeAsString('\n INFO: [${dt.toIso8601String()}] $e', mode: FileMode.append);
  }
}
