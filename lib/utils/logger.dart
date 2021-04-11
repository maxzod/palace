import 'dart:async';
import 'dart:io';
import 'package:ansicolor/ansicolor.dart';

import 'package:palace/utils/yaml_parser.dart';
import 'package:path/path.dart';

abstract class _Logger {
  static final _red = AnsiPen()..red(bold: true);
  static final _yellow = AnsiPen()..yellow(bold: true);
  static final _blue = AnsiPen()..blue(bold: true);

  static void red(Object msg) {
    print(_Logger._red(msg));
  }

  static void blue(Object msg) {
    print(_Logger._blue(msg));
  }

  static void yellow(Object msg) {
    print(_Logger._yellow(msg));
  }
}

class Logger {
  static DateTime get dt => DateTime.now();
  static Directory get logFolder => Directory(Directory.current.path + '\\logs\\');
  static FutureOr<File> get logFile async {
    final path = join(Directory(Directory.current.path + '\\logs\\').path + '${dt.year}-${dt.month}-${dt.day}.log');
    final _logFile = File(path);

    if (!await File(path).exists()) {
      await Directory(logFolder.path).create();
    }

    return _logFile;
  }

  static Future<String> e(Object e, {StackTrace? st}) async {
    final _msg = '\n ERROR: [${dt.toIso8601String()}] $e ${st != null ? '\n $st' : ''}';
    _Logger.red(e);
    await (await logFile).writeAsString(_msg, mode: FileMode.append);
    return _msg;
  }

  static Future<String> v(Object e, {StackTrace? st}) async {
    final _msg = '\n VERBOSE: [${dt.toIso8601String()}] $e ${st != null ? '\n $st' : ''}';
    _Logger.yellow(e);
    await (await logFile).writeAsString(_msg, mode: FileMode.append);
    return _msg;
  }

  static Future<String> l(Object e, {StackTrace? st}) async {
    final _msg = '\n LOG: [${dt.toIso8601String()}] $e ${st != null ? '\n $st' : ''}';
    print(e);
    await (await logFile).writeAsString(_msg, mode: FileMode.append);
    return _msg;
  }

  static Future<String> i(Object e, {StackTrace? st}) async {
    final _msg = '\n INFO: [${dt.toIso8601String()}] $e ${st != null ? '\n $st' : ''}';
    _Logger.blue(e);

    await (await logFile).writeAsString(_msg, mode: FileMode.append);
    return _msg;
  }

  /// log the error to the console only
  static String c(Object e, {StackTrace? st, AnsiPen? color}) {
    final _msg = 'LOG : [${dt.toIso8601String()}] $e ${st != null ? '\n $st' : ''}';
    print(_msg);
    return _msg;
  }

  static Future<String> whenEnabled(Object e, {StackTrace? st}) async {
    final _msg = 'LOG : [${dt.toIso8601String()}] $e ${st != null ? '\n $st' : ''}';
    if (await allowLogs) {
      print(_msg);
      return _msg;
    } else {
      return _msg;
    }
  }
}
