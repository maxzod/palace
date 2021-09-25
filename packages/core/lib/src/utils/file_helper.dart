import 'dart:io';

import 'package:mime_type/mime_type.dart';
import 'package:path/path.dart';

String getFileName(File file) {
  final name = basename(file.path);
  return Uri.parse(name).toString();
}

String? getFileMimeType(File file) => mime(file.path);

ContentType? getFileContentType(File file) {
  final _fileMemeType = getFileMimeType(file);

  /// files without known extension
  if (_fileMemeType != null) {
    final split = _fileMemeType.split('/');
    return ContentType(split[0], split[1]);
  }
  return null;
}
