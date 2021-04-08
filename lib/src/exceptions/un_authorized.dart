import 'package:palace/src/exceptions/imp_exception.dart';

class Unauthorized extends PalaceException {
  Unauthorized({
    Object? data,
  }) : super(HttpStatus.unauthorized, data: data);

  @override
  Map<String, dynamic> toMap() {
    return {
      'status_code': HttpStatus.unauthorized,
      'message': 'Un Authorized',
      if (data != null) 'data': data,
    };
  }
}
