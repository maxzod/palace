import 'dart:io';

import 'package:palace/palace.dart';
import 'package:palace/utils/file_helper.dart';
import 'package:path/path.dart';

Future<void> file(HttpRequest request, HttpResponse response, File file) async {
  /// find the full path to the file
  final _file = File(join(Directory.current.path, file.path));

  /// get the file name
  final _name = getFileName(_file);

  /// if the file does not exist will response with 404
  if (!await _file.exists()) throw NotFound();

  /// set the response to download the file
  request.response.headers.add('Content-Disposition', 'attachment;filename=$_name');

  /// set the content type
  _setContentType(request.response, _file);

  /// response with the file
  return response.addStream(_file.openRead());
}

void _setContentType(HttpResponse response, File file) {
  final setToFileType = response.headers.contentType == null || response.headers.contentType?.mimeType == 'text/plain';
  if (setToFileType) {
    response.headers.contentType = getFileContentType(file);
  } else {
    response.headers.contentType == ContentType.binary;
  }
}
