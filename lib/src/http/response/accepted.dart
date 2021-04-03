import 'dart:io' as io;
import 'package:palace/palace.dart';

extension ResponseWithAccepted on Response {
  Future<void> accepted({
    Object? data,
  }) async {
    /// set the Response contentType to Json
    response.headers.contentType = io.ContentType.json;

    response.statusCode = io.HttpStatus.notFound;

    /// append the data to the response
    await write(toJson(
      {
        'status_code': io.HttpStatus.accepted,
        'message': 'Accepted',
        if (data != null) 'data': data,
      },
    ));
  }
}
