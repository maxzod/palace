import 'package:palace/src/exceptions/imp_exception.dart';

class BadRequest extends PalaceException {
  BadRequest({
    Object? data,
  }) : super(HttpStatus.badRequest, data: data);
}
