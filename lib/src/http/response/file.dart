import 'dart:convert' show utf8;

import 'dart:io';

import 'response.dart';
import 'not_found.dart';
import 'package:mime_type/mime_type.dart';

extension ResponseWithFile on Response {
  Future<void> file(String name, String path) async {
    try {
      // final _name = utf8.url(name);

      // response.headers.add('Content-Encoding', 'deflate, gzip');
      request.headers.contentType = ContentType('text', 'html');
      request.headers.add('Content-Disposition', 'attachment; filename=$name');
      // response.headers.add('Content-Type', 'application/json; charset=utf-8');

      final file = File(Directory.current.path + '/files' + path);
      final exists = await file.exists();
      print(file.path);
      if (!exists) {
        await notFound();
      }
      response.setContentTypeFromFile(file);
      await response.addStream(file.openRead());
      await response.close();
    } catch (e) {
      print(e);
    }
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
