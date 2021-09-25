import 'package:core/src/http/responses/imp.dart';

class Unauthorized extends PalaceResponse {
  Unauthorized([Object? data])
      : super(
          statusCode: HttpStatus.unauthorized,
          data: data,
        );

  @override
  String get message => 'Un Authorized';
}
