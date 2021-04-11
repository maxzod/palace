import 'dart:io' as io;
import 'package:palace/palace.dart';

/// status code 202

extension ResponseWithAccepted on Response {
  /// will response with status code 202
  /// will end the request life-cycle
  /// the guards still work but the can not respond or
  /// modify the response any more
  Future<void> accepted({
    Object? data,
  }) async {
    /// set the status code
    response.statusCode = io.HttpStatus.accepted;

    /// append the data to the response
    await json(
      {
        'status_code': io.HttpStatus.accepted,
        'message': 'Accepted',
        if (data != null) 'data': data,
      },
    );
  }
}
