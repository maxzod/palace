import 'package:palace/src/exceptions/imp_exception.dart';

class NotFound extends PalaceException {
  NotFound({
    Object? data,
  }) : super(HttpStatus.notFound, data: data);

  @override
  Map<String, dynamic> toMap() {
    return {
      'status_code': HttpStatus.notFound,
      'message': 'Not found',
      if (data != null) 'data': data,
    };
  }
}
