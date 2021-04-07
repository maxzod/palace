import 'package:palace/src/exceptions/imp_exception.dart';

class Unauthorized extends PalaceException {
  Unauthorized({
    Object? data,
  }) : super(HttpStatus.unauthorized, data: data);
}
