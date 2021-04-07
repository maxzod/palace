import 'package:palace/src/exceptions/imp_exception.dart';

class NotFound extends PalaceException {
  NotFound({
    Object? data,
  }) : super(HttpStatus.notFound, data: data);
}
