import 'package:palace/palace.dart';

import 'dart:io' as io;

extension ResponseWithUnAuthorized on Response {
  // will send the data converted to json
  // if no statusCode was provided it will will set the status code to the defaultCode based on the request;
  Future<void> unAuthorized({
    Object? data,
  }) async {
    /// set the Response contentType to Json
    response.headers.contentType = io.ContentType.json;

    /// set the status code to 404

    response.statusCode = io.HttpStatus.notFound;

    /// append the data to the response
    await send(toJson(
      {
        'status_code': io.HttpStatus.notFound,
        'message': 'Not found',
        if (data != null) 'data': data,
      },
    ));
  }
}
