import 'dart:io';

import 'package:mime_type/mime_type.dart';

String getFileName(File file) {
  var fileName = (file.path.split('/').last);
  return file.path.replaceAll('/$fileName', '');
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
