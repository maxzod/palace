library palace_logger;

export 'src/entry.dart';

import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';

class Log {
  Log._();
  static DateTime get dt => DateTime.now();

  static Directory get logFolder =>
      Directory(Directory.current.path + '\\logs\\');
  static FutureOr<File> get logFile async {
    final path = join(Directory(Directory.current.path + '\\logs\\').path +
        '${dt.year}-${dt.month}-${dt.day}.log');
    final _logFile = File(path);

    if (!await File(path).exists()) {
      await Directory(logFolder.path).create();
    }

    return _logFile;
  }

  static Future<String> e(Object e, {StackTrace? st}) async {
    final _msg =
        '\n ERROR: [${dt.toIso8601String()}] $e ${st != null ? '\n $st' : ''}';
    Log.c(e, st: st);
    await (await logFile).writeAsString(_msg, mode: FileMode.append);
    return _msg;
  }

  static Future<String> v(Object e, {StackTrace? st}) async {
    final _msg =
        '\n VERBOSE: [${dt.toIso8601String()}] $e ${st != null ? '\n $st' : ''}';
    Log.c(e, st: st);
    await (await logFile).writeAsString(_msg, mode: FileMode.append);
    return _msg;
  }

  static Future<String> l(Object e, {StackTrace? st}) async {
    final _msg =
        '\n LOG: [${dt.toIso8601String()}] $e ${st != null ? '\n $st' : ''}';
    Log.c(e, st: st);
    await (await logFile).writeAsString(_msg, mode: FileMode.append);
    return _msg;
  }

  static Future<String> i(Object e, {StackTrace? st}) async {
    final _msg =
        '\n INFO: [${dt.toIso8601String()}] $e ${st != null ? '\n $st' : ''}';
    Log.c(e, st: st);
    await (await logFile).writeAsString(_msg, mode: FileMode.append);
    return _msg;
  }

  /// log the error to the console only
  static String c(Object e, {StackTrace? st}) {
    final _msg =
        'LOG : [${dt.toIso8601String()}] $e ${st != null ? '\n $st' : ''}';

    print(_msg);
    return _msg;
  }
}
