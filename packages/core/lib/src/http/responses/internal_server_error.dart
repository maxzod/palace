import 'package:core/src/http/responses/imp.dart';

class InternalServerError extends PalaceResponse {
  /// use `data` => if you want to add more details to the client side use it
  /// use `exception` => if you want to display the exception `BUT`
  /// ! it will be sent to client side in debug mode only
  final Object? exception;
  InternalServerError([Object? data, this.exception])
      : super(
          statusCode: HttpStatus.internalServerError,
          data: data,
        );

  @override
  String get message => 'Internal Server Error';
  @override
  Map<String, dynamic> toMap() {
    return {
      'status_code': HttpStatus.internalServerError,
      'message': message,
      if (data != null) 'data': data,
      if (exception != null) 'exception': exception
    };
  }
}
