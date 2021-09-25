import 'package:core/src/http/responses/imp.dart';

class Accepted extends PalaceResponse {
  Accepted([Object? data])
      : super(
          statusCode: HttpStatus.accepted,
          data: data,
        );

  @override
  String get message => 'Accepted';
}
