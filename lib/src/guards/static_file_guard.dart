import 'dart:io';
import 'package:palace/palace.dart';

class PublicFilesGuard {
  final String folderName;

  PublicFilesGuard({this.folderName = '/public'});
  void call(Request req, Response res, next) async {
    final assetsFolderName = folderName.replaceAll('/', '').replaceAll('\\', '');
    final firstPart = req.request.uri.path.split('/').where((e) => e.isNotEmpty);
    if (firstPart.isNotEmpty && firstPart.first == assetsFolderName) {
      final filePath = req.request.uri.path.replaceFirst('/', '');
      final file = File(filePath);
      final exists = await file.exists();
      if (!exists) {
        return res.notFound();
      }
      res.response.headers.contentType = getContentTypeForFile(res.response.headers.contentType, file);
      await res.response.addStream(file.openRead());
    }
    await next();
  }
}

ContentType? getContentTypeForFile(ContentType? contentType, File file) {
  if (contentType == null || contentType.mimeType == ContentType.text.mimeType) {
    return getFileContentType(file);
  } else {
    return ContentType.binary;
  }
}
