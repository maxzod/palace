import 'dart:io' as io;
import 'package:palace/palace.dart';

/// status code 400

extension ResponseWithBadRequest on Response {
  Future<void> badRequest({
    Object? data,
  }) async {
    /// set the status code to 400
    response.statusCode = io.HttpStatus.badRequest;

    /// append the data to the response
    await json(
      {
        'status_code': io.HttpStatus.badRequest,
        'message': 'Bad Request',
        if (data != null) 'data': data,
      },
    );
  }
}
