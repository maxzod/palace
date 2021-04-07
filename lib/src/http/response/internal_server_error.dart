import 'package:palace/palace.dart';
import 'dart:io' as io;

extension ResponseWithInternalServerError on Response {
  /// use `data` => if you want to add more details to the client side use it
  /// use `exception` => if you want to display the exception `BUT`
  /// ! it will be sent to client side in debug mode only
  Future<void> internalServerError({
    Object? data,
    Object? exception,
  }) async {
    try {
      await json(
        {
          'status_code': io.HttpStatus.internalServerError,
          'message': 'Internal Server Error',
          if (data != null) 'data': data,
          if (exception != null) 'exception': exception
          // if (exception != null && !isInProduction) 'exception': exception
        },
        statusCode: io.HttpStatus.internalServerError,
      );
    } finally {}
  }
}
