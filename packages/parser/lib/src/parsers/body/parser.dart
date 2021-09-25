import 'dart:io';

import 'package:palace_body_parser/src/helpers/conent_type_to_enum.dart';

Future<Map<String, dynamic>> parseTheReqBody(HttpRequest req) async {
  final contentTypesList =
      req.headers['contentType'] ?? req.headers['content-type'];

  if (contentTypesList == null || contentTypesList.isEmpty) return {};

  final contentType = stringToContentType(contentTypesList);
  switch (contentType) {
    case RequestContentType.xml:
    case RequestContentType.json:
    case RequestContentType.text:
    case RequestContentType.multiPartFormData:
    case RequestContentType.formEcoded:
      throw UnimplementedError("$contentType is not supported yet");
  }
}

Future<Map<String, dynamic>> parseRawJson(HttpRequest req) async {
  return {};
}
