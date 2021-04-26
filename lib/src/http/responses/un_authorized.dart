import 'package:palace/src/imp/palace_response.dart';

class Unauthorized extends PalaceResponse {
  Unauthorized([Object? data])
      : super(
          statusCode: HttpStatus.unauthorized,
          data: data,
        );

  @override
  String get message => 'Un Authorized';
}
