import 'package:palace/src/exceptions/imp_exception.dart';

class BadRequest extends PalaceException {
  BadRequest({
    Object? data,
  }) : super(HttpStatus.badRequest, data: data);

  @override
  Map<String, dynamic> toMap() {
    return {
      'status_code': HttpStatus.badRequest,
      'message': 'Bad Request',
      if (data != null) 'data': data,
    };
  }
}
