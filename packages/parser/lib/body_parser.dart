library body_parser;

import 'dart:io';

import 'package:palace_body_parser/src/models/result.dart';

import 'src/parsers/body/parser.dart';
import 'src/parsers/query/parser.dart';

export 'src/models/result.dart';

// * prase the IO request to Result object
Future<Result> parseIoReq(HttpRequest request) async {
  // * parse the request query
  final queryResult = parseTheReqQuery(request);

  // * parse the request body
  final bodyResult = await parseTheReqBody(request);

  // *  the result object
  final result = Result(body: bodyResult, query: await queryResult);

  return result;
}
