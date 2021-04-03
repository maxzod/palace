import 'dart:io';

import 'package:path/path.dart';

class PalaceLogger {
  static DateTime get dt => DateTime.now();
  static Directory get logFolder =>
      Directory(Directory.current.path + '\\logs\\');
  static String get _fileName =>
      join(logFolder.path + '${dt.year}-${dt.month}-${dt.day}.log');

  static Future<void> e(Object e) async {
    if (await logFolder.exists()) {
      await File(_fileName).writeAsString(
          '\n ERROR: [${dt.toIso8601String()}] $e',
          mode: FileMode.append);
    } else {
      await Directory(logFolder.path).create();
      await File(_fileName).writeAsString(
          '\n ERROR: [${dt.toIso8601String()}] $e',
          mode: FileMode.append);
    }
  }

  static Future<void> l(Object e) async {
    if (await logFolder.exists()) {
      await File(_fileName).writeAsString(
          '\n LOG: [${dt.toIso8601String()}] $e',
          mode: FileMode.append);
    } else {
      await Directory(logFolder.path).create();
      await File(_fileName).writeAsString(
          '\n LOG: [${dt.toIso8601String()}] $e',
          mode: FileMode.append);
    }
  }

  static Future<void> i(Object e) async {
    if (await logFolder.exists()) {
      await File(_fileName).writeAsString(
          '\n INFO: [${dt.toIso8601String()}] $e',
          mode: FileMode.append);
    } else {
      await Directory(logFolder.path).create();
      await File(_fileName).writeAsString(
          '\n INFO: [${dt.toIso8601String()}] $e',
          mode: FileMode.append);
    }
  }
}
