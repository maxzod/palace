import 'dart:convert' show AsciiDecoder, AsciiEncoder, utf8;

import 'dart:io';

import 'response.dart';
import 'not_found.dart';
import 'package:mime_type/mime_type.dart';

extension ResponseWithFile on Response {
  Future<void> file(String path, {String? name}) async {
    // final fileNameInUtfList = utf8.encode(name);
    // final buffer = StringBuffer();
    // fileNameInUtfList.forEach((element) => buffer.write(element));
    // request.response.headers.add('Content-Disposition', 'attachment; filename="EURO rates.txt"; filename*=UTF-8\'\'${buffer.toString()}');

    request.response.headers.add('Content-Disposition', "attachment; filename='EURO rates.txt'; filename*=UTF-8''${name ?? ""}");
    print('there');
    final file = File(Directory.current.path + '/files' + path);
    final exists = await file.exists();
    print(file.path);
    if (!exists) {
      await notFound();
    }
    response.setContentTypeFromFile(file);
    await response.addStream(file.openRead());
    await response.close();
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
