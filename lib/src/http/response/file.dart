import 'dart:io';

import 'package:palace/palace.dart';
import 'package:palace/utils/file_helper.dart';
import 'package:path/path.dart';

extension ResponseWithFile on Response {
  Future<void> file(String path, {String? name}) async {
    assert(path.trim().isNotEmpty, 'Palace ERROR : file path can not be empty ! ');
    final file = File(join(Directory.current.path, path));
    final _name = name ?? getFileName(file);
    request.response.headers.add('Content-Disposition', 'attachment;filename=$_name');
    if (!await file.exists()) return await notFound();
    _setContentType(request.response, file);
    return response.addStream(file.openRead());
  }

  void _setContentType(HttpResponse response, File file) {
    final setToFileType = response.headers.contentType == null || response.headers.contentType?.mimeType == 'text/plain';
    if (setToFileType) {
      response.headers.contentType = getFileContentType(file);
    } else {
      response.headers.contentType == ContentType.binary;
    }
  }
}
