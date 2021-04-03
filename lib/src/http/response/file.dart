import 'dart:io';

import 'response.dart';
import 'not_found.dart';
import 'package:mime_type/mime_type.dart';

extension ResponseWithFile on Response {
  Future<void> file(String path, {String? name}) async {
    final file = File(Directory.current.path + '/private' + path);

    late String _name;
    if (name != null) {
      _name = Uri.parse(name).toString();
    } else {
      var fileName = (file.path.split('/').last);
      _name = file.path.replaceAll('/$fileName', '');
    }

    request.response.headers
        .add('Content-Disposition', 'attachment;filename=$_name');
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
    if (headers.contentType == null ||
        headers.contentType!.mimeType == 'text/plain') {
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
