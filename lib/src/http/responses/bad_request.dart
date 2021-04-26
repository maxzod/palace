import 'package:palace/src/imp/palace_response.dart';

class BadRequest extends PalaceResponse {
  BadRequest([Object? data])
      : super(
          statusCode: HttpStatus.badRequest,
          data: data,
        );

  @override
  String get message => 'Bad Request';
}
