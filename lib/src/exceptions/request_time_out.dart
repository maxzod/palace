import 'package:palace/src/exceptions/imp_exception.dart';

class RequestTimeout extends PalaceException {
  RequestTimeout({
    Object? data,
  }) : super(HttpStatus.badRequest, data: data);

  @override
  Map<String, dynamic> toMap() {
    return {
      'status_code': HttpStatus.requestTimeout,
      'message': 'Request Time Out',
      if (data != null) 'data': data,
    };
  }
}
