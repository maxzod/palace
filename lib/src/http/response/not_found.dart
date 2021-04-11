import 'package:palace/palace.dart';

import 'dart:io' as io;

extension ResponseWithNotFound on Response {
  // will send the data converted to json
  // if no statusCode was provided it will will set the status code to the defaultCode based on the request;
  Future<void> notFound({
    Object? data,
  }) async {
    /// append the data to the response
    await json(
      {
        'status_code': io.HttpStatus.notFound,
        'message': 'Not found',
        if (data != null) 'data': data,
      },
    );
  }
}
