import 'package:core/src/http/responses/imp.dart';

class Forbidden extends PalaceResponse {
  Forbidden([Object? data])
      : super(
          statusCode: HttpStatus.forbidden,
          data: data,
        );

  @override
  String get message => 'Forbidden';
}
