import 'dart:io';
import 'package:palace/palace.dart';

class PublicFilesGuard {
  final String path;
  PublicFilesGuard({this.path = '/public'});
  void call(Request req, Response res, Function next) async {
    final isToPublicFiles = req.method == 'GET' && _getNameFromPath(path) == _getNameFromPath(req.path);
    if (isToPublicFiles) {
      final file = File(req.path.replaceFirst('/', ''));
      if (!await file.exists()) {
        throw NotFound();
      }
      res.response.headers.contentType = getContentTypeForFile(res.response.headers.contentType, file);
      await res.response.addStream(file.openRead());
    } else {
      await next();
    }
  }
}

ContentType? getContentTypeForFile(ContentType? contentType, File file) {
  if (contentType == null || contentType.mimeType == ContentType.text.mimeType) {
    return getFileContentType(file);
  } else {
    return ContentType.binary;
  }
}

String _getNameFromPath(String path) {
  final pathInFragments = path.split('/')..removeWhere((e) => e.isEmpty);
  return pathInFragments.isNotEmpty ? pathInFragments.first : '';
}
