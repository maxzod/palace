import 'package:palace/src/exceptions/imp_exception.dart';

class NotAcceptable extends PalaceException {
  NotAcceptable({
    Object? data,
  }) : super(HttpStatus.notFound, data: data);

  @override
  Map<String, dynamic> toMap() {
    return {
      'status_code': HttpStatus.notAcceptable,
      'message': 'Not Acceptable',
      if (data != null) 'data': data,
    };
  }
}
