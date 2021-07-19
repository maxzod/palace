import 'package:palace/src/imp/palace_response.dart';

class Ok extends PalaceResponse {
  Ok([Object? data])
      : super(
          statusCode: HttpStatus.ok,
          data: data,
        );

  @override
  String get message => 'Ok';
}
