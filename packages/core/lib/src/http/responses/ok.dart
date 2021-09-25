import 'package:core/src/http/responses/imp.dart';

class Ok extends PalaceResponse {
  Ok([Object? data])
      : super(
          statusCode: HttpStatus.ok,
          data: data,
        );

  @override
  String get message => 'Ok';
}
