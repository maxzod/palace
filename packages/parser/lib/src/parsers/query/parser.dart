import 'dart:io';

import '../../helpers/string_to_acctual_type.dart';

// * extract the query from the request and convert it to the acctual type
// example
// '1' => 1 type of int
// '2.5' => 1 type of double
// [1,2,3,4] => type of List ..etc
Future<Map<String, dynamic>> parseTheReqQuery(HttpRequest req) async {
  /// the request query
  /// ! value is type of string
  final data = req.uri.queryParameters;

  /// placeholder to contain the parser result
  final queryResult = <String, dynamic>{};

  /// *  for each key convert the value to the acctual type
  for (final key in data.keys) {
    queryResult[key] = convertStringToAcctualType(data[key]!);
  }

  /// * return the parsed query result
  return queryResult;
}
