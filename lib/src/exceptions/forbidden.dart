import 'package:palace/src/exceptions/imp_exception.dart';

class Forbidden extends PalaceException {
  Forbidden({
    Object? data,
  }) : super(HttpStatus.notFound, data: data);

  @override
  Map<String, dynamic> toMap() {
    return {
      'status_code': HttpStatus.forbidden,
      'message': 'Forbidden',
      if (data != null) 'data': data,
    };
  }
}
