import 'dart:io';

import 'response.dart';
import 'not_found.dart';
import 'package:mime_type/mime_type.dart';

extension ResponseWithFile on Response {
  Future<void> file(String name, String path) async {
    final _name = Uri.parse(name).toString();
    request.response.headers.add('Content-Disposition', 'attachment;filename=$_name');
    ;

    final file = File(Directory.current.path + '/files' + path);
    final exists = await file.exists();
    if (!exists) {
      await notFound();
    }
    response.setContentTypeFromFile(file);
    await response.addStream(file.openRead());
  }
}

extension SS on HttpResponse {
  void setContentTypeFromFile(File file) {
    if (headers.contentType == null || headers.contentType!.mimeType == 'text/plain') {
      headers.contentType = file.contentType;
    } else {
      headers.contentType == ContentType.binary;
    }
  }
}

extension FileHelpers on File {
  /// Get the mimeType as a string
  ///
  String? get mimeType => mime(path);

  /// Get the contentType header from the current
  ///
  ContentType? get contentType {
    final mimeType = this.mimeType;
    if (mimeType != null) {
      final split = mimeType.split('/');
      return ContentType(split[0], split[1]);
    }
  }
}
