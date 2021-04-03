import 'dart:io';
import 'package:http_server/http_server.dart';

Future main() async {
  var staticFiles = VirtualDirectory('public');
  staticFiles.allowDirectoryListing = true;

  if (true) {
    //! Change to false if you show listing page
    staticFiles.directoryHandler = (dir, request) {
      var indexUri = Uri.file(dir.path).resolve('index.html');
      staticFiles.serveFile(File(indexUri.toFilePath()), request);
    };
  }

  var server = await HttpServer.bind(InternetAddress.loopbackIPv4, 3000);
  await server.forEach(staticFiles.serveRequest);
}
