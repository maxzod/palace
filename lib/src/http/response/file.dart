import 'dart:io';

import 'package:palace/palace.dart';
import 'package:palace/utils/file_helper.dart';
import 'package:path/path.dart';

extension ResponseWithFile on Response {
  Future<void> file(String path, {String? name}) async {
    assert(
        path.trim().isNotEmpty, 'Palace ERROR : file path can not be empty ! ');

    /// find the full path to the file
    final file = File(join(Directory.current.path, path));

    /// get the file name
    final _name = name ?? getFileName(file);

    /// if the file does not exist will response with 404
    if (!await file.exists()) return await notFound();

    /// set the response to download the file
    request.response.headers
        .add('Content-Disposition', 'attachment;filename=$_name');

    /// set the content type
    _setContentType(request.response, file);

    /// response with the file
    return response.addStream(file.openRead());
  }

  void _setContentType(HttpResponse response, File file) {
    final setToFileType = response.headers.contentType == null ||
        response.headers.contentType?.mimeType == 'text/plain';
    if (setToFileType) {
      response.headers.contentType = getFileContentType(file);
    } else {
      response.headers.contentType == ContentType.binary;
    }
  }
}
