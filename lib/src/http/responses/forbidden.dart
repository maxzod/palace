import 'package:palace/src/imp/palace_response.dart';

class Forbidden extends PalaceResponse {
  Forbidden([Object? data])
      : super(
          statusCode: HttpStatus.forbidden,
          data: data,
        );

  @override
  String get message => 'Forbidden';
}
